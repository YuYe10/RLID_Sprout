function after_R=Encryption(R,x1,y1,a,b,dimen,key)

[matrix1,matrix2]=chaos(R,x1,y1,a,b,key);
after_subR=substitution(dimen,R,matrix2);
after_R=P_box(after_subR,dimen,matrix1);
