function [final_cost, final_theta0, final_theta1] = cost_function(theta0, theta1, epsilon, golden, MAX_STEPS)

  m = length(golden);
  x = [0:1:m];
  theta0_range = [theta0: epsilon: theta0+MAX_STEPS];
  theta1_range = [theta1: epsilon: theta1+MAX_STEPS];

  final_cost = 10000000;
  for z0 = 1:length(theta0_range)
    for z1 = 1:length(theta1_range)
      sum_diff_squared = 0;
      cost = 0;
      diff = 0;
      diff_squarded = 0;
      for i =1:length(golden)
        diff = (theta0_range(z0) + x(i)*theta1_range(z1)) - golden(i);
        diff_squared = diff * diff;
        sum_diff_squared = sum_diff_squared + diff_squared;
      end
      cost = (1/(2*m)) * sum_diff_squared;
      if (cost < final_cost)
        final_cost = cost;
        final_theta0 = theta0_range(z0);
        final_theta1 = theta1_range(z1);
      endif
    end
  end
end

