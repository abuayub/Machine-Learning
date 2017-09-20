function [signals,EVal] = pcatrain(data,labels,k)
    % PCA1: Perform PCA using covariance.
    % data - MxN matrix of input data
    % (M dimensions, N trials)
    % signals - MxN matrix of projected data
    % PC - each column is a PC
    % V - Mx1 matrix of variances
    [M,N] = size(data);
    % subtract off the mean for each dimension
    mn = mean(data,2);
    MN = repmat(mn,1,N);
    data = data -MN ;
    % calculate the covariance matrix
    covariance = cov(data);
    % find the eigenvectors and eigenvalues
    [EVal, V] = eigs(covariance,k);
    % extract diagonal of matrix as vector
    %V = diag(V);
    % sort the variances in decreasing order
    %[junk, rindices] = sort(-1*V);
    %PC = PC(:,rindices);
    % project the original data set
    %signals = EVal' * data';
    signals = data*EVal;
    figure
    plot(V);
end