function [theta] = logistic_regression_GD(name,alpha,lambda,iter)

data = load(name);
X = data(:,1:end-1);
y = data(:,end);
n = size(X,2);
m = size(X,1);

%Feature Scaling
mu = mean(X,1);
sigma = std(X,1);
X_norm = [ones(m,1) (X-repmat(mu,m,1))./repmat(sigma,m,1)];

%Gradient Descent
theta = zeros(n+1,1);
logcost_con = zeros(1,iter);
for i = 1:iter
    theta = theta - alpha*((1/m)*sum((sigmoid(X_norm*theta)-y)'*X_norm,2)+...
                          (lambda/m)*[0; theta(2:end)]);
    logcost = -(1/m)* sum(y.*log(sigmoid(X_norm*theta))+ ...
                      (1-y).*log(1-sigmoid(X_norm*theta))) + ...
                      (lambda/(2*m))*theta(2:end)'*theta(2:end);
    logcost_con(i) = logcost;
end

%Final theta
theta(1) = theta(1) - (mu./sigma)*(theta(2:end));
theta(2:end) = theta(2:end)./sigma';
plot(logcost_con)
end 