function orders=per_oriders(t_matrix)
arry_p1=reshape(t_matrix,[],1);
[L_1,H1] = sort(arry_p1,'descend'); % H1¼´ÎªÖÃ»»¾ØÕó,L_sÎŞÓÃ
orders=H1;