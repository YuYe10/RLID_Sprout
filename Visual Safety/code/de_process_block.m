function after_block=de_process_block(dimen,block,vec1)
num=dimen^2;%块中像素的数量
group_num=num-1;%像素组的数量
line=blo2line(block);%把块以行顺序换成一行
after_line=line;

for i=group_num:-1:1
    begin_line=i;
    end_line=i+1;
    group=after_line(begin_line:end_line);%取出像素组
    t_random=vec1(i);%取出随机数
    after_group=Decry_group(group,t_random);%解密像素组
    after_line(begin_line:end_line)=after_group;
end
t_block=reshape(after_line,dimen,dimen);%将元素重新变成一块，以列的顺序进行
after_block=t_block';%将块转置