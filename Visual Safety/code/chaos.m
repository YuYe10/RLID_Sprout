function [vec1,vec2]=chaos(group_num,x1,y1,a,b,t)
%vec1用于替换，长度为group_num；vec2用于置换 长度为group_num+1

x=zeros(1,group_num);
y=zeros(1,group_num+1);
x(1)=rem(x1,1);
y(1)=rem(y1,1);
t=t+500;


for i=1:1:group_num+1+t
   [x(i+1),y(i+1)]= two_D_LSM(x(i),y(i),a,b);
end

vec1=x(t+2:end-1);
vec2=y(t+2:end);

