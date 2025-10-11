rng(2)
R=floor(unifrnd(50,200,4,4));

x1=0.2;
y1=0.3;
a=50;
b=50;
dimen=2;

[matrix1,matrix2]=chaos(R,x1,y1,a,b);
after_subR=substitution(dimen,R,matrix2);
after_R=P_box(after_subR,dimen,matrix1);
