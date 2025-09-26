%rank_2,两个像素的rank

function r=rank_2(group_2)
group_2=double(group_2);
a=group_2(1);
b=group_2(2);

s=double(a+b);
if s<=255
   r=a;
else
    begin_x=s-255;
    r=a-begin_x;
    
end