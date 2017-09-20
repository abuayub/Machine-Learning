function task4
    global trainl testl c;
    trainl = 320;
    testl = 80;
    c = 40;
    f= 400;
    file= 'attfull.csv';
    x= csvread(file);
    file1= 'attLabel.csv';
    y= csvread(file1);
    acc =0;
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
        [J,EVal] = pcatrain(train,trainLabels,320);
        [L] = pcatest(test,testLabels,EVal);
        disp('Train Data after PCA:');disp(size(J));
        disp('Test Data after PCA:');disp(size(L));
        [trainData,EVec] = ldatrain(J,trainLabels);
        [testData] = ldatest(L,testLabels,EVec);
        newacc = knn(trainData,testData,trainLabels,testLabels);%(J,L,trainLabels,testLabels);
        acc= acc + newacc;
        disp('Train Data after LDA:');disp(size(trainData));
        disp('Test Data after LDA:');disp(size(testData));
        disp('Finished PCA-LDA-KNN for fold:');disp(round((k/2)+.99));
        disp('Accuracy:');disp(newacc);
        
        %disp('KFold:');disp(k);
        %disp('size of train:');disp(size(train));
        %disp('size of test:');disp(size(test));
    end
    disp('Final Accuracy');disp(acc/5);
    end