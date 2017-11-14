function [theta] = svm(X,y,C)
%binary SVM WIP

%feature scaling 
X  = feature_scaling(X);
[m,n] = size(X);
theta = zeros(m,1);

%new features from kernel
X_f = zeros(size(X));
for i = 1:m
    for j = 1:m
X_f(i,j) = gaussian_kernel(X(i,:),X(j,:),1);
    end
end

%optimization
J = C*(y'*relu(-X*theta'-1)+(1-y')*relu(X*theta'+1))+ (1/2)*(theta'*theta);
    

