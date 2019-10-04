clear; clf;

X = [0:1:9];
Y = 0.5*X + 1;
Y2 = [0.9, 1.6, 2.4, 2.3, 3.1, 3.6, 3.7, 4.5, 5.1, 5.3];

figure;
plot(X,Y, X, Y2, 'ko')
grid on;
title('Model Representation')
xlabel('x')
ylabel('y')
saveas(gcf, 'model_representation.png')
