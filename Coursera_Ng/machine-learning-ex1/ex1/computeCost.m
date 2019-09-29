function J = computeCost(X, y, theta)
%COMPUTECOST Compute cost for linear regression
%   J = COMPUTECOST(X, y, theta) computes the cost of using theta as the
%   parameter for linear regression to fit the data points in X and y

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost of a particular choice of theta
%               You should set J to the cost.

%div = 1/(2*m);

%step = 0;
%for i = 1:m,
  %printf("Step = %f X(i,1) = %f X(i,2) = %f y(i) = %f\n", step, X(i,1), X(i,2), y(i));
%  step = step + ((theta(1)*X(i,1) + theta(2)*X(i,2)) -y(i))^2;
%endfor
%J = div * step;

i = 1:m;
J = (1/(2*m)) * sum( ((theta(1) + theta(2) .* X(i,2)) - y(i)) .^ 2); % Un-Vectorized


% =========================================================================

end
