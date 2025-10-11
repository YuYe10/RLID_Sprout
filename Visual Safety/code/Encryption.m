function [key,after_R]=Encryption(R,dimen,key)
group_num=dimen^2-1;
[x,y]=size(R);
dimen_x=x/dimen;
dimen_y=y/dimen;


for i=1:1:dimen_x
   for j=1:1:dimen_y
       [x1,y1,a,b,r]=KeyDecon(key);%对密钥进行分解,前四位为浮点数，最后一位是随机数
       [vec1,vec2]=chaos(group_num,x1,y1,a,b,r);%%vec1用于替换，长度为group_num；vec2用于置换 长度为group_num+1
       vec1=round(abs(vec1)*100000);


       %替换加密
        begin_x=dimen*(i-1)+1;
        end_x=dimen*i;
        begin_y=dimen*(j-1)+1;
        end_y=dimen*j;

        block=R(begin_x:end_x,begin_y:end_y);%把块截取出 
        after_b=process_block(dimen,block,vec1);%对块中像素组置换加密

        
%         R(begin_x:end_x,begin_y:end_y)=after_b;%加密后的块放入图像中


        %置换加密
        matrix2=reshape(vec2,dimen,dimen);%将元素重新变成一块，以列的顺序进行
        t_per=matrix2;%取出混沌序列的元素
       orders=per_oriders(t_per);%置换顺序
       after_t=after_b(orders);%块中元素打乱,为一列
       blo_t=reshape(after_t,dimen,dimen);%将一列元素重新变成一块，以列的顺序进行
       R(begin_x:end_x,begin_y:end_y)=blo_t;


       %%%%%hash生成下一个块的密钥 原始块+密钥
       line=blo2line(block);%把块以行顺序换成一行

       key=sha256([line(1:64) uint8(key)]);
   end
end

after_R=R;


%after_subR=substitution(dimen,R,vec1);
%after_R=P_box(after_subR,dimen,vec2);
