function Y = softmax_row(X)
Y = exp(X)./repmat(sum(exp(X),2),1,size(X,2));
end