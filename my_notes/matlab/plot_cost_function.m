clear;

theta = zeros(2,1); % 2 rows x 1 column of 0
Y_GOLDEN = [0.9, 1.6, 2.4, 2.3, 3.1, 3.6, 3.7, 4.5, 5.1, 5.3]';
m = length(Y_GOLDEN);
x = [0:1:m]';
x = [ones(m,1), x(1:10,1)];
Y1 = hypothesis_linear(0,0, x);
Y2 = hypothesis_linear(1,0.5, x);
Y3 = hypothesis_linear(0.75,0.75, x);

figure;
plot(x(:,2), Y_GOLDEN, 'ko', 'DisplayName', 'Y_GOLDEN')
grid on;
hold on;
plot(x(:,2), Y1)
plot(x(:,2), Y2)
plot(x(:,2), Y3)
hold off
legend("Y\_GOLDEN", '\theta_{0} =0, \theta_{1} = 0', ['\theta_{0}=1, ' ...
                    '\theta_{1} = 0.5'], '\theta_{0} =0.75, \theta_{1} = 0.75')
xlabel("x")
ylabel("y")
title('Cost Function for h_{\theta}(x) = \theta_{0} + \theta_{1} * x')
saveas(gcf, 'plot_cost_function.png')
