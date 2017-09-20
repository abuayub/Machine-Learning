function task2
    global trainl testl c;
    trainl = 320;
    testl = 80;
    c = 40;
    f= 400;
    file= 'atthalf.csv';
    x= csvread(file);
    file1= 'attLabel.csv';
    y= csvread(file1);
    acc =0;
    for k=1:+2:10
        j=1;m=1;
        train=zeros(trainl,2576);
        test=zeros(testl,2576);
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
        [trainData,EVal] = pcatrain(train,trainLabels,80);
        [testData] = pcatest(test,testLabels,EVal);
        newacc = knn(trainData,testData,trainLabels,testLabels);
        acc= acc + newacc;
        disp('Finished PCA-KNN-ATT-Resize for fold:');disp(round((k/2)+.99));
        disp('Train Data after PCA:');disp(size(trainData));
        disp('Test Data after PCA:');disp(size(testData));
        disp('Accuracy:');disp(newacc);
        %acc= acc +knn(trainData,testData,trainLabels,testLabels);
        %disp('KFold:');disp(k);
        %disp('size of train:');disp(size(train));
        %disp('size of test:');disp(size(test));
    end
    disp('Final Accuracy');disp(acc/5);
    end