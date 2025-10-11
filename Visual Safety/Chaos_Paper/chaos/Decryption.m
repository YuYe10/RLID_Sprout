
function after_R=Decryption(R,x1,y1,a,b,dimen,key)
[x,y]=size(R);
dimen_x=x/dimen;
dimen_y=y/dimen;

[matrix1,matrix2]=chaos(R,x1,y1,a,b,key);%matrix1用户permutation,matrix2用于substitution
R=De_I(R,dimen,matrix1);

matrix2=round(abs(matrix2)*10000);
for i=1:1:dimen_x
   for j=1:1:dimen_y
        %key=key+i*1000+j*10000;%删除删除！！
        begin_x=dimen*(i-1)+1;
        end_x=dimen*i;
        begin_y=dimen*(j-1)+1;
        end_y=dimen*j;
        t_matrix2=matrix2(begin_x:end_x,begin_y:end_y);%把块截取出 
        block=R(begin_x:end_x,begin_y:end_y);%把块截取出 
        after_b=de_process_block(dimen,block,t_matrix2);%对块中像素组置换加密
        after_R(begin_x:end_x,begin_y:end_y)=after_b;%加密后的块放入图像中
   end
end
