%解密像素组
function  after_group=Decry_group(group,r_group)
group=double(group);
s=sum(sum(group(:)));%像素组之和
num=domain_2(s);%具有相同和的像素组数量

    
    r=rank_2(group);
    
    ram = sum(r_group);
    en_r=mod(r-ram,num);
    after_group=rank_opposite_2(s,en_r);
    


% after_r=rank(after_group);
% re_r=Decry_r(after_r,num,key);
% re_group=rank_opposite(re_r,s);
% 
% if re_group~=group
%    pause;
% end