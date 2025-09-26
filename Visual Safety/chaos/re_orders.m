%逆置换顺序

function re_locate=re_orders(arry)

i=1;
pix_num=length(arry);
re_locate=zeros(pix_num,1);
while i<=pix_num%确定置乱的对应位置
   re_locate(i)=find(arry==i);
    i=i+1;
end