function LinearSVM
    global l c;
    l = 200;
    c = 40;
    f= 400;
    file= 'attfull.csv';
    x= csvread(file);
    train=zeros(l,10304);
    test=zeros(l,10304);
    j=1;
    for i=1:+10:f
        train(j:j+4,:)=x(i:i+4,:);
        test(j:j+4,:)=x(i+5:i+9,:);
        j=j+5;
    end

	[w,wo] = trainSVM(train*0.001);
    acc1 = testSVM(test*0.001,w,wo);
    
    [v,vo] = trainSVM(test*0.001);
    acc2 = testSVM(train*0.001,v,vo);
    disp(' Accuracy 1:');disp(acc1);
    disp(' Accuracy 2:');disp(acc2);
    acc = (acc1+acc2)/2;
    disp('Final Accuracy:');disp(acc);
end

function [g,go] = trainSVM(x)
    global l c;
    g=zeros(c,10304);
    go=zeros(c,1);
    for i=1:+5:l
        z=-ones(l,1);
        z(i:i+4) = 1;
        %disp(z);
        H = (x * x').* (z * z');
        f= -ones(l,1);
        A= -eye(l);
        a=zeros(l,1);
        B=[[z]';[zeros(l-1,l)]];
        b= zeros(l,1);
        lb= zeros(l,1);
        ub= zeros(l,1);
        ub(:) = 100;
        
        alpha = quadprog(H+eye(l)*0.001, f, A, a, B, b,lb,ub);
        %disp(alpha)
        %alpha_set(:,round(1+i/5))= alpha;
        %disp(size(alpha_set))
        w= (alpha.*z)'*x;
        w=w';
        wo=(1/z(i,:))-w'*x(i,:)';
        disp(z(i,:));
        disp('size of w:');disp(size(w));
        disp(' wo:');disp(wo);
        g(round(1+i/5),:)=w;
        go(round(1+i/5),:)=wo;
    end
    %disp(g);
    %disp(go);
    %disp(size(g));
    %disp(size(go));
end

function acc = testSVM(t,w,wo)
    global l c;
    filename1 = 'z.csv';
    Z=csvread(filename1);
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