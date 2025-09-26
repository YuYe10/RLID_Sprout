function after_I=substitution(dimen,R,matrix2)
[x,y]=size(R);
dimen_x=x/dimen;
dimen_y=y/dimen;
after_R=R;
matrix2=round(abs(matrix2)*10000);
for i=1:1:dimen_x
   for j=1:1:dimen_y
        %key=key+i*1000+j*10000;%删除删除！！
        begin_x=dimen*(i-1)+1;
        end_x=dimen*i;
        begin_y=dimen*(j-1)+1;
        end_y=dimen*j;
        t_matrix2=matrix2(begin_x:end_x,begin_y:end_y);%把块截取出 
%         %%%%%%%%%%差分攻击-begin%%%%%%%%%%%%%%%%%%%%%%
%         if t_matrix2(1,1)==0
%            t_matrix2(1,1)=255; 
%         else
%             t_matrix2(1,1)=0;
%         end
%         %%%%%%%%%%差分攻击-end%%%%%%%%%%%%%%%%%%%%%%
        block=R(begin_x:end_x,begin_y:end_y);%把块截取出 
        after_b=process_block(dimen,block,t_matrix2);%对块中像素组置换加密
        after_R(begin_x:end_x,begin_y:end_y)=after_b;%加密后的块放入图像中
   end
end

after_I=after_R;