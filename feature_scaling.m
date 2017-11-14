function X = feature_scaling(X)
X = bsxfun(@rdivide,bsxfun(@minus,X,mean(X)),std(X));
end