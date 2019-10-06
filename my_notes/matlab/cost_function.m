function J = cost_function(X, y, theta)
% This function computes the cost for this specific pair of theta values.
% It is expecting theta to be a 2 element vector.
 theta
 
  % Initialize some useful values
  m = length(y); % number of training examples
  
  % You need to return the following variables correctly 
  J = 0;

  i = 1:m;
  J = (1/(2*m)) * sum( ((theta(1).*X(i,1) + theta(2) .* X(i,2)) - y(i)) .^ 2);
  
end
