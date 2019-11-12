clear; 

Y_GOLDEN = [0.9, 1.6, 2.4, 2.3, 3.1, 3.6, 3.7, 4.5, 5.1, 5.3, 5.6]'
theta = zeros(2,1); % 2 rows x 1 column of 0

m = length(Y_GOLDEN);
x = [0:1:m]';
x = [ones(m,1), x(:,1)]
J_min = cost_function(x, Y_GOLDEN, [1, 0.5])

