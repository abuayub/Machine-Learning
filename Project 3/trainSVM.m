function [g,go] = trainSVM(x,trainLabels)
    c = 40;
    l= size(trainLabels,1);
    m = size(x,2);
    g=zeros(c,m);
    go=zeros(c,1);
    for i=1:+8:l
        z=-ones(l,1);
        z(i:i+7) = 1;
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
        %disp('size of w:');disp(size(w));
        %disp(' wo:');disp(wo);
        g(round(1+i/8),:)=w;
        go(round(1+i/8),:)=wo;
    end
    %disp(g);
    %disp(go);
    %disp(size(g));
    %disp(size(go));
end