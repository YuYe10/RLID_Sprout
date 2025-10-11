%rank_opposite_2

function group=rank_opposite_2(s_2,after_r)
if s_2<=255
   b=after_r;
   c=s_2-b;
else
    begin_x=s_2-255;
    b=begin_x+after_r;
    c=s_2-b;
end
group=[b,c];