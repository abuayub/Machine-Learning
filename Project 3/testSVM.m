function acc = testSVM(t,w,wo,Z)
    c = 40;
    l = 80; %size(Z,1);
    %filename1 = 'z.csv';
    %Z=csvread(filename1);
    res = zeros(c,1);
    testclass = zeros(c,1);
    count =0;
    predictedclass= zeros(l,2);
    actualclass = zeros(l,1);
    for i=1:l
       x=t(i,:);
        for j=1:c
            r = w(j,:)*x'+wo(j,:);
            %disp(size(r));
            res(j,1)=r;
            testclass(j,1)=j;
        end
        [M,I] =max(res);
        %disp('Max dist from x:');disp(M);
        %disp('Index :');disp(I);
        testcase= testclass(I,:);
        predictedclass(i,1) = testcase;
        predictedclass(i,2) = Z(i,:);
        actualclass(i,:) =Z(i,:);
        %disp('Predicted case:');disp(testcase);
        %disp('Testing case:');disp(Z(i,:));
        if(testcase == Z(i,:))
            count=count+1;
        end
        %disp('-----------------------------------------');
    end
    disp('Correct predicts:');disp(count);
    acc = count/l*100;
end