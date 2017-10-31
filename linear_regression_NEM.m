function [theta] = linear_regression_NEM(name)

data = load(name);
X = data(:,1:end-1);
y = data(:,end);
m = size(X,1);

X_p = [ones(m,1) X];
theta = pinv(X_p'*X_p)*X_p'*y;
end
