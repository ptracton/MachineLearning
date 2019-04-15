#! /usr/bin/env python3

import numpy as np
import matplotlib
import matplotlib.pyplot as plt

import scipy
import scipy.signal
import scipy.integrate

import mne
import mne.time_frequency

def bandpower_mtp(data, sf, band, method='welch', window_sec=None, relative=False):
    """Compute the average power of the signal x in a specific frequency band.

    Requires MNE-Python >= 0.14.

    Parameters
    ----------
    data : 1d-array
      Input signal in the time-domain.
    sf : float
      Sampling frequency of the data.
    band : list
      Lower and upper frequencies of the band of interest.
    method : string
      Periodogram method: 'welch' or 'multitaper'
    window_sec : float
      Length of each window in seconds. Useful only if method == 'welch'.
      If None, window_sec = (1 / min(band)) * 2.
    relative : boolean
      If True, return the relative power (= divided by the total power of the signal).
      If False (default), return the absolute power.

    Return
    ------
    bp : float
      Absolute or relative band power.
    """
    band = np.asarray(band)
    low, high = band

    # Compute the modified periodogram (Welch)
    if method == 'welch':
        if window_sec is not None:
            nperseg = window_sec * sf
        else:
            nperseg = (2 / low) * sf

        freqs, psd = scipy.signal.welch(data, sf, nperseg=nperseg)

    elif method == 'multitaper':
        psd, freqs = mne.time_frequency.psd_array_multitaper(data, sf, adaptive=True,
                                                             normalization='full', verbose=0)

    # Frequency resolution
    freq_res = freqs[1] - freqs[0]

    # Find index of band in frequency vector
    idx_band = np.logical_and(freqs >= low, freqs <= high)

    # Integral approximation of the spectrum using parabola (Simpson's rule)
    bp = scipy.integrate.simps(psd[idx_band], dx=freq_res)

    if relative:
        bp /= scipy.integrate.simps(psd, dx=freq_res)
    return bp

def bandpower(data, sf, band, window_sec=None, relative=False):
    """Compute the average power of the signal x in a specific frequency band.

    Parameters
    ----------
    data : 1d-array
        Input signal in the time-domain.
    sf : float
        Sampling frequency of the data.
    band : list
        Lower and upper frequencies of the band of interest.
    window_sec : float
        Length of each window in seconds.
        If None, window_sec = (1 / min(band)) * 2
    relative : boolean
        If True, return the relative power (= divided by the total power of the signal).
        If False (default), return the absolute power.

    Return
    ------
    bp : float
        Absolute or relative band power.
    """
    band = np.asarray(band)
    low, high = band

    # Define window length
    if window_sec is not None:
        nperseg = window_sec * sf
    else:
        nperseg = (2 / low) * sf

    # Compute the modified periodogram (Welch)
    freqs, psd = scipy.signal.welch(data, sf, nperseg=nperseg)

    # Frequency resolution
    freq_res = freqs[1] - freqs[0]

    # Find closest indices of band in frequency vector
    idx_band = np.logical_and(freqs >= low, freqs <= high)

    # Integral approximation of the spectrum using Simpson's rule.
    bp = scipy.integrate.simps(psd[idx_band], dx=freq_res)

    if relative:
        bp /= scipy.integrate.simps(psd, dx=freq_res)
    return bp

def find_intersection(frequency=None, low=None, high=None):
    return np.logical_and(freqs >= low, freqs <= high)

def average_power(frequency=None, bands=None, in_range=None):
    # Frequency resolution
    freq_res = frequency[1] - frequency[0]  # = 1 / 4 = 0.25
    power = scipy.integrate.simps(bands[in_range], dx=freq_res)
    return power

def relative_power(frequency=None, bands=None, average_power=None):
    # Relative delta power (expressed as a percentage of total power)
    freq_res = frequency[1] - frequency[0]  # = 1 / 4 = 0.25
    total_power = scipy.integrate.simps(bands, dx=freq_res)
    rel_power = average_power / total_power
    return rel_power

if __name__ == "__main__":
    data = np.loadtxt('data.txt')
    sf = 100.
    time = np.arange(data.size) / sf

    fig, ax = plt.subplots(1, 1, figsize=(12, 4))
    plt.plot(time, data, lw=1.5, color='k')
    plt.xlabel('Time (seconds)')
    plt.ylabel('Voltage')
    plt.xlim([time.min(), time.max()])
    plt.title('N3 sleep EEG data (F3)')
    #    plt.show()


    # Define window length (4 seconds)
    win = 4 * sf
    freqs, psd = scipy.signal.welch(data, sf, nperseg=win)
    print(freqs)
    print(max(freqs)) # has the frequency range of the signal, x-axis
    print(psd)
    print(max(psd))  # has the peaks of signal, y-axis, psd= Power Spectral Density

    plt.figure(figsize=(8, 4))
    plt.plot(freqs, psd, color='k', lw=2)
    plt.xlabel('Frequency (Hz)')
    plt.ylabel('Power spectral density (V^2 / Hz)')
    plt.ylim([0, psd.max() * 1.1])
    plt.title("Welch's periodogram")
    plt.xlim([0, freqs.max()])
    #plt.show()

    # delta band from 0.5hz to 4 hz
    idx_delta = find_intersection(freqs, 0.5, 4)
    print(idx_delta)

    plt.figure(figsize=(7, 4))
    plt.plot(freqs, psd, lw=2, color='k')
    plt.fill_between(freqs, psd, where=idx_delta, color='skyblue')
    plt.xlabel('Frequency (Hz)')
    plt.ylabel('Power spectral density (uV^2 / Hz)')
    plt.xlim([0, 10])
    plt.ylim([0, psd.max() * 1.1])
    plt.title("Welch's periodogram")
    #    plt.show()

    delta_average_power = average_power(freqs, psd, idx_delta)
    print('Average delta power: %.3f uV^2' % delta_average_power)

    delta_relative_power = relative_power(freqs, psd, delta_average_power)
    print('Relative delta power: %.3f' % delta_relative_power)

    window_seconds = 4
    delta_range = [0.5, 4]
    theta_range = [4,8]
    alpha_range = [8,12]
    beta_range = [12, 30]

    delta_average_power = bandpower(data, sf, delta_range, window_seconds)
    print("Delta Average Power = {}".format(delta_average_power))
    delta_relative_power = bandpower(data, sf, delta_range, window_seconds, True)
    print("Delta Relative Power = {} ".format(delta_relative_power))

    beta_average_power =  bandpower(data, sf, beta_range, window_seconds)
    print("Beta Average = {}".format(beta_average_power))
    print("Delta/Beta Average Ratio = {}".format(delta_average_power/beta_average_power))

    #delta_average_power_mtp = bandpower_mtp(data, sf, delta_range, "multitaper", window_seconds)
    #print(delta_average_power_mtp)
    # Multitaper delta power
    bp = bandpower_mtp(data, sf, delta_range, 'multitaper')
    bp_rel = bandpower_mtp(data, sf, delta_range, 'multitaper', relative=True)
    print('Absolute delta power: %.3f' % bp)
    print('Relative delta power: %.3f' % bp_rel)

    # Delta-beta ratio
    # One advantage of the multitaper is that we don't need to define a window length.
    db = bandpower_mtp(data, sf, [0.5, 4], 'multitaper') / bandpower_mtp(data, sf, [12, 30], 'multitaper')
    # Ratio based on the relative power
    db_rel = bandpower_mtp(data, sf, [0.5, 4], 'multitaper', relative=True) / \
                                                                   bandpower_mtp(data, sf, [12, 30], 'multitaper', relative=True)
    print('Delta/beta ratio (absolute): %.3f' % db)
    print('Delta/beta ratio (relative): %.3f' % db_rel)
