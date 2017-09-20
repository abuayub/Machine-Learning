function acc = LinearSVM(train,test,trainLabels,testLables)
    global l c;
    c = 40;
    l = size(trainLabels,1);
	[w,wo] = trainSVM(train*0.001,trainLabels);
    acc = testSVM(test*0.001,w,wo,testLables);
    
    disp(' Accuracy SVM:');disp(acc);
end



