function [x,y]=two_D_LSM(x1,y1,a,b)

x=cos(4*a*x1*(1-x1)+b*sin(pi*y1)+1);
y=cos(4*a*y1*(1-y1)+b*sin(pi*x1)+1);