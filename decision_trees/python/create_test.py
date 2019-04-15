#! /usr/bin/env python3

import argparse
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


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='Create Data')
    parser.add_argument("-D", "--debug",
                        help="Debug this script",
                        action="store_true")


    args = parser.parse_args()
    if args.debug:
        print(args)


    #x_data0, sine_wave0 = create_sin_wave(1, 10, 1, 1024)
    #x_data1, sine_wave1 = create_sin_wave(1.5, 15, 1, 1024)
    #sin_mixed = sine_wave0 + sine_wave1

    ##fft_data = np.fft.fft(sin_mixed)
    #print(fft_data)
    #bp = bandpower(fft_data, 10, 0, 20)
    #print("FFT BP = {}".format(bp))

    #plt.plot(x_data0, sine_wave0)
    #plt.plot(x_data1, sine_wave1)
    #plt.plot(x_data0, sin_mixed)
    #plt.plot(x_data0, fft_data)
    #plt.show()

    delta_range = [0.5, 4]
    theta_range = [4,8]
    alpha_range = [8,12]
    beta_range = [12, 30]

    data = np.loadtxt("EEGData/Z001.txt")
    print("Raw Data {}".format(data))
    sf = 173.61 # http://epileptologie-bonn.de/cms/front_content.php?idcat=193&lang=3&changelang=3
    time = np.arange(data.size) / sf

    delta_power = bandpower_mtp(data, sf, delta_range, 'multitaper')
    theta_power = bandpower_mtp(data, sf, theta_range, 'multitaper')
    alpha_power = bandpower_mtp(data, sf, alpha_range, 'multitaper')
    beta_power = bandpower_mtp(data, sf, beta_range, 'multitaper')

    print("Delta Power = {}".format(delta_power))
    print("Theta Power = {}".format(theta_power))
    print("Alpha Power = {}".format(alpha_power))
    print("Beta Power = {}".format(beta_power))

    freq= np.fft.fft(data)**2
    print("FFT Freq = {}".format(freq))
    #print("FFT PSD = {}".format(psd))

    plt.plot(time, data)
    plt.plot(time, freq)
    plt.show()
