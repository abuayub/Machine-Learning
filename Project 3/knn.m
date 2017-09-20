function acc = knn(TrainData,TestData,trainLabels,testLabels)
    k=1;
    % TrainData = importdata(trainfilename,delimiterIn);
    % TestData = importdata(testfilename,delimiterIn);
    noOfTestColumn = size(TestData,1);
    noOfTrainColumns = size(TrainData,1);
    result = [noOfTestColumn,1];
    for i=1:noOfTestColumn
        curData = TestData(i,:);
        Q= repmat(curData,noOfTrainColumns,1);
        Z= (Q-(TrainData));
        X= Z.^2;
        Y= sum(X,2);
        E_distance = sqrt(Y);
        E_distance = horzcat(trainLabels,E_distance);
        %E_distance = E_distance';
        E_distance_sort = sortrows(E_distance,2);
        result(1,i)= E_distance_sort(1,1);
    end
    count =0;
    match = horzcat(testLabels,result');
    for i=1:noOfTestColumn
        if(match(i,1)==match(i,2))
            count = count +1;
        end
    end
    acc = (count/noOfTestColumn)*100;
end