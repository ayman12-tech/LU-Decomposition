clc;
clear all;
A=xlsread('Matrix1.xlsx') %reading matrix from excel
[n,~]=size(A); 
b=[152.6;585.6;2488.8]
l=zeros(n,n);
%calculating L11
l(1,1)=sqrt(A(1,1))

%calculating L21 and L31 
for i=2:n
  l(i,1)=A(i,1)/l(1,1)
end
%calculating L22 and L32
for i=2:n-1
  l(i,i)=sqrt(A(i,i)-(l(i,i-1))*(l(i,i-1)))
  l(i:n,i)=(A(i:n,i)-l(i,i-1)*l(i:n,i-1))/l(i,i)
end
%calculating L33
l(n,n)=sqrt(A(n,n)-(l(n,n-2)*l(n,n-2))-(l(n,n-1)*l(n,n-1)));

L=l
fprintf('Transpose:')
U=l' %trasnpose

%forward substitution
y= zeros(n,1); 
for i=1:n
  y(i) = ( b(i) - L(i, :)*y )/L(i, i);  
end
fprintf('Y-values are:\n')
disp(y)

%backward substitution
x(n,:)=y(n,:)/U(n,n);
for i=n-1:-1:1
  x(i,:)=(y(i,:)-U(i,i+1:n)*x(i+1:n,:))/U(i,i);
end
fprintf('X-values are:\n')
disp(x)



