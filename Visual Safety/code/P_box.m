function after_I=P_box(I,dimen,vec2)

after_I=I;

[m,n]=size(I);
matrix2=reshape(vec2,dimen,dimen);%将元素重新变成一块，以列的顺序进行
b_x=m/dimen;
b_y=n/dimen;

for i=1:1:b_x
   x_begin=(i-1)*dimen+1;
   x_end=i*dimen;
   for j=1:1:b_y
       y_begin=(j-1)*dimen+1;
       y_end=j*dimen;
       t_matrix=after_I(x_begin:x_end,y_begin:y_end);%取出块中的元素
       t_per=matrix2;%取出混沌序列的元素
       orders=per_oriders(t_per);%置换顺序
       after_t=t_matrix(orders);%块中元素打乱,为一列
       blo_t=reshape(after_t,dimen,dimen);%将一列元素重新变成一块，以列的顺序进行
       after_I(x_begin:x_end,y_begin:y_end)=blo_t;
   end
end
