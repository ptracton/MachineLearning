function [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters)
%GRADIENTDESCENT Performs gradient descent to learn theta
%   theta = GRADIENTDESCENT(X, y, theta, alpha, num_iters) updates theta by 
%   taking num_iters gradient steps with learning rate alpha

% Initialize some useful values
m = length(y); % number of training examples
J_history = zeros(num_iters, 1);
printf("Theta(1)=%f Theta(2)=%f alpha=%f num_iters=%f\n", theta(1), theta(2), alpha, num_iters);
for iter = 1:num_iters

    % ====================== YOUR CODE HERE ======================
    % Instructions: Perform a single gradient step on the parameter vector
    %               theta. 
    %
    % Hint: While debugging, it can be useful to print out the values
    %       of the cost function (computeCost) and gradient here.
    %
    % ============================================================

    % Save the cost J in every iteration    

    %printf("Iter = %d J = %f Theta(1) = %f Theta(2)=%f\n", iter, J_history(iter), theta(1), theta(2));
  
    k = 1:m;
    t1 = sum((theta(1) + theta(2) .* X(k,2)) - y(k)); % Un-Vectorized
    t2 = sum(((theta(1) + theta(2) .* X(k,2)) - y(k)) .* X(k,2)); % Un-Vectorized
    
    theta(1) = theta(1) - (alpha/m) * (t1);
    theta(2) = theta(2) - (alpha/m) * (t2);
    
    % Save the cost J in every iteration    
    J_history(iter) = computeCost(X, y, theta);

    %for k = 1:m,
    % for i = 1:m,
    %    t1 = sum((theta(1) + theta(2) * X(i,2)) - y(i)); % Un-Vectorized
    %    t2 = sum(((theta(1) + theta(2) * X(i,2)) - y(i)) * X(i,2)); % Un-Vectorized
    %  endfor  
    %  theta(1) = theta(1) - (alpha/m) * (t1);
    %  theta(2) = theta(2) - (alpha/m) * (t2);
    
      % Save the cost J in every iteration    
    %  J_history(iter) = computeCost(X, y, theta);
    %endfor
    
end
