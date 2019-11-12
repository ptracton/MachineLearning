function [final_cost, final_theta0, final_theta1] = gradient_descent(theta,epsilon, golden, MAX_STEPS)

m = length(golden);
x = [0:1:m]';
x = [ones(m+1,1), x(:,1)];
theta0_range = [theta(1): epsilon: theta(1)+MAX_STEPS];
theta1_range = [theta(2): epsilon: theta(2)+MAX_STEPS];

final_cost = 10000000;
for z0 = 1:length(theta0_range)
    for z1 = 1:length(theta1_range)
        sum_diff_squared = 0;
        cost = 0;
        diff = 0;
        diff_squarded = 0;
        theta_values = [theta0_range(z0), theta1_range(z1)];
        for i =1:length(golden)
          diff = (theta0_range(z0) + x(i)*theta1_range(z1)) - golden(i);
          diff_squared = diff * diff;
          sum_diff_squared = sum_diff_squared + diff_squared;
        end
        cost = (1/(2*m)) * sum_diff_squared;
        if (cost(1) < final_cost)
            printf("\n")
            final_cost = cost(1)
            final_theta0 = theta0_range(z0)
            final_theta1 = theta1_range(z1)
            endif        
        end
    end
end

