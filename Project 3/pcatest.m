function [signals] = pcaTest(data,labels,EVal)
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
    
    signals = data*EVal;
end