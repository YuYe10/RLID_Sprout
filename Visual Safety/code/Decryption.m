
function [key,after_R]=Decryption(R,dimen,key)
[x,y]=size(R);
dimen_x=x/dimen;
dimen_y=y/dimen;

% R=De_I(R,dimen,vec2);
group_num=dimen^2-1;
for i=1:1:dimen_x
   for j=1:1:dimen_y
        [x1,y1,a,b,r]=KeyDecon(key);%对密钥进行分解,前四位为浮点数，最后一位是随机数
        [vec1,vec2]=chaos(group_num,x1,y1,a,b,r);%%vec1用于替换，长度为group_num；vec2用于置换 长度为group_num+1
        vec1=round(abs(vec1)*100000);
        matrix2=reshape(vec2,dimen,dimen);%将元素重新变成一块，以列的顺序进行


        begin_x=dimen*(i-1)+1;
        end_x=dimen*i;
        begin_y=dimen*(j-1)+1;
        end_y=dimen*j;


       t_matrix=R(begin_x:end_x,begin_y:end_y);%取出块中的元素
       t_per=matrix2;%取出混沌序列的元素
       orders=per_oriders(t_per);%置换顺序
       re_locate=re_orders(orders);%逆置换顺序
       
       after_t=t_matrix(re_locate);%块中元素打乱,为一列
       blo_t=reshape(after_t,dimen,dimen);%将一列元素重新变成一块，以列的顺序进行



        %替换解密
       line=blo2line(blo_t);%把块以行顺序换成一行
        after_line=line;

        for g=group_num:-1:1
             begin_line=g;
             end_line=g+1;
             group=after_line(begin_line:end_line);%取出像素组
            t_random=vec1(g);%取出随机数
            after_group=Decry_group(group,t_random);%解密像素组
            after_line(begin_line:end_line)=after_group;
        end
        t_block=reshape(after_line,dimen,dimen);%将元素重新变成一块，以列的顺序进行
        after_block=t_block';%将块转置
        after_R(begin_x:end_x,begin_y:end_y)=after_block;

               %%%%%hash生成下一个块的密钥 原始块+密钥
       line=blo2line(after_block);%把块以行顺序换成一行

       key=sha256([line uint8(key)]);
   end
end
