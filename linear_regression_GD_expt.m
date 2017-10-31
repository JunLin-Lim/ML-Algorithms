function [theta] = linear_regression_GD_expt(name,iter)

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
alpha = [0.001 0.003 0.01 0.03 0.1 0.3 1];

MSE_con = zeros(length(alpha),iter);
theta_matrix = [];
for i = 1:length(alpha)
    theta = zeros(n+1,1);
for j = 1:iter
%while abs(MSE_con(end) - MSE_con(end-1)) < 1e-5
    theta = theta - ((alpha(i)/m)*(X_norm*theta-y)'*X_norm)';
    MSE = (1/(2*m))*(X_norm*theta-y)'*(X_norm*theta-y);
    MSE_con(i,j) = MSE;
end
theta_matrix = [theta_matrix theta];
end
theta = theta_matrix(:,find(MSE_con(:,end)==min(MSE_con(:,end))));
plot(MSE_con')
legend(num2str(alpha'))
end