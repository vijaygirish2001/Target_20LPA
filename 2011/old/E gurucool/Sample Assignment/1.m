 

x(1) =exp(1)/(16-exp(1));
x1(1)=x(1)+x(1)^2;
h=1/100;
x2(1)=1+2*x(1);
x3(1)=2;
range1=1;
range2=2.77;
No_samples=(range2-range1)/h;
for k=1:No_samples
    t=1+k*h;
    x_val(k)=x(1)+x1(1)*h+x2(1)*h^2/2+x3(1)*h^3/FACTORIAL(3);
    x_valo(k)=e^(t) / (16 �e^ (t))
end
