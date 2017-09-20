function[signals,EVal] = ldatrain(train,labels)
    data= train;
    len = size(train,2);
    Sw = zeros(len,len);
    for i= 1:40
        t=sum(labels(:)==i);
        newclass = data(i*t-7:i*t,:);
        covariance = cov(newclass);
        sample = t-1;
        Sw = Sw + (sample*covariance);
        
    end
    [M,N] = size(data);
    % subtract off the mean for each dimension
    mn = mean(data,2);
    MN = repmat(mn,1,N);
    data = data -MN ;
    St = cov(data);
    Sb = St - Sw;
    clear MN St mn covariance newclass
    %find eigen values and vectors
    [EVal, V]= eigs(pinv(Sw)*Sb,39);
    EVal = real(EVal);
    signals = data*EVal;
    figure
    plot(real(V));
end