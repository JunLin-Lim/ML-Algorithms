function [X_pca,vector_right] = my_pca(X,threshold)
% Normalization
m = size(X,1);
X_mu = mean(X);
X_sigma = std(X);
X_normalized = (X-repmat(X_mu,m,1))./repmat(X_sigma,m,1);
[vector_right,D] = eig(X_normalized'*X_normalized);
eigenvalues= sum(D,2);
eigenvalues_percent = eigenvalues/sum(eigenvalues);

i = 0; total_eigen_percent = 0;
while total_eigen_percent < threshold
    i = i+1;
    total_eigen_percent = total_eigen_percent + eigenvalues_percent(end+1-i);
end
k = clock;
ind = strcat('-',int2str(floor(k(4))),'-',int2str(floor(k(5))),'-',int2str(floor(k(6))));
vector_right = vector_right(:,end+1-i:end);
X_pca = X_normalized*vector_right;
csvwrite(strcat('X_pca',ind,'.csv'),X_pca);