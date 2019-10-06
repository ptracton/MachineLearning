function hypothesis  = hypothesis_linear(theta0, theta1, x)
  hypothesis =  theta0*x(:,1) + theta1 *x(:,2);
end
