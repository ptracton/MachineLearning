function [final_cost, final_theta0, final_theta1] = cost_function_optimized(theta0, theta1, epsilon, golden, MAX_STEPS)

  m = length(golden);
  x = [0:1:m]
  theta0_range = [theta0: epsilon: theta0+MAX_STEPS]
  theta1_range = [theta1: epsilon: theta1+MAX_STEPS]

  diff = theta0_range + (x.*theta1_range) .- y
  final_cost = 0;
  final_theta0 = 0;
  final_theta1 = 0;
end

