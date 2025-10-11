%对块进行处理
%dimen=维度，block=处理的块，t_matrix2=r矩阵
function after_block=process_block(dimen,block,t_matrix2)
num=dimen^2;%块中像素的数量
group_num=num/2;%像素组的数量
line=blo2line(block);%把块以行顺序换成一行
line_r=blo2line(t_matrix2);
after_line=line;

for i=1:1:group_num
   begin_line=(i-1)*2+1;%像素组开始的地方 
   end_line=i*2;
   r_group=line_r(begin_line:end_line);
   group=line(begin_line:end_line);%像素组
   after_group=Encry_group(group,r_group);%加密像素组
   after_line(begin_line:end_line)=after_group;
end
t_block=reshape(after_line,dimen,dimen);%将元素重新变成一块，以列的顺序进行
after_block=t_block';%将块转置