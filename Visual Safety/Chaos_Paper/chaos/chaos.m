function [matrix1,matrix2]=chaos(I,x1,y1,a,b,key)
[m,n]=size(I);
len=m*n;%混沌序列的长度
x=zeros(1,len);
y=zeros(1,len);
x(1)=x1;
y(1)=y1;
rng(key)
t=randperm(1000,1)+500; 

for i=1:1:len+t
   [x(i+1),y(i+1)]= two_D_LSM(x(i),y(i),a,b);
end

x=x(t+2:end);
y=y(t+2:end);

matrix1=reshape(x,m,n);
matrix2=reshape(y,m,n);