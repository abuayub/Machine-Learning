function kfold
    global trainl testl c;
    trainl = 320;
    testl = 80;
    c = 40;
    f= 400;
    file= 'attfull.csv';
    x= csvread(file);
    file1= 'attLabel.csv';
    y= csvread(file1);
    
    for k=1:+2:10
        j=1;m=1;
        train=zeros(trainl,10304);
        test=zeros(testl,10304);
        trainLabels=zeros(trainl,1);
        testLabels=zeros(testl,1);
        for i=1:+2:f
            if k == mod(i,10)
                test(j:j+1,:)= x(i:i+1,:);
                testLabels(j:j+1,:)= y(i:i+1,:);
                j= j+2;
            else
                train(m:m+1,:)= x(i:i+1,:);
                trainLabels(m:m+1,:)= y(i:i+1,:);
                m=m+2;
            end
        end
        %call for next
        disp('KFold:');disp(k);
        disp('size of train:');disp(size(train));
        disp('size of test:');disp(size(test));
    end
    end