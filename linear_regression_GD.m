function [theta] = linear_regression_GD(name,alpha,iter)

data = load(name);
X = data(:,1:end-1);
y = data(:,end);

%Feature Scaling
n = size(X,2);
m = size(X,1);
mu = mean(X,1);
sigma = std(X,1);
X_norm = [ones(m,1) (X-repmat(mu,m,1))./repmat(sigma,m,1)];

%Gradient Descent
theta = zeros(n+1,1);
MSE_con = [];
for i = 1:iter
%while abs(MSE_con(end) - MSE_con(end-1)) < 1e-5
    theta = theta - ((alpha/m)*(X_norm*theta-y)'*X_norm)';
    MSE = (1/(2*m))*(X_norm*theta-y)'*(X_norm*theta-y);
    MSE_con = [MSE_con MSE];
end
%Final theta
theta(1) = theta(1) - (mu./sigma)*(theta(2:end));
theta(2:end) = theta(2:end)./sigma';
%plot(MSE_con)
end