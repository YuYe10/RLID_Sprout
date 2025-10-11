%对块进行处理
%dimen=维度，block=处理的块，t_matrix2=r矩阵
function after_block=process_block(dimen,block,vec1)
num=dimen^2;%块中像素的数量
group_num=num-1;%像素组的数量


line=blo2line(block);%把块以行顺序换成一行

for i=1:1:group_num
    begin_line=i;
    end_line=i+1;
    group=line(begin_line:end_line);%取出像素组
    t_random=vec1(i);%取出随机数
    after_group=Encry_group(group,t_random);%加密像素组
    line(begin_line:end_line)=after_group;
end
t_block=reshape(line,dimen,dimen);%将元素重新变成一块，以列的顺序进行
after_block=t_block';%将块转置