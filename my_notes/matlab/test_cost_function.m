clear; 

Y_GOLDEN = [0.9, 1.6, 2.4, 2.3, 3.1, 3.6, 3.7, 4.5, 5.1, 5.3];
[cost, theta0, theta1]= cost_function(0,0,0.1, Y_GOLDEN, 3)
[cost, theta0, theta1]= cost_function_optimized(0,0,0.1, Y_GOLDEN, 3)
