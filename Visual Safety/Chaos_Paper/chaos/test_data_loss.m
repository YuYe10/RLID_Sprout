x1=0.2;
y1=0.3;
a=50;
b=50;
key=100;
dimen=32;
I=imread('hu.png');
en_bit_dimen_pathname='I:\Codes\RLID\Visual Safety\Chaos_Paper\chaos\image\robustness\';
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);

pro=0.16;
after_R=Encryption(R,x1,y1,a,b,dimen,key);
after_G=Encryption(G,x1,y1,a,b,dimen,key);
after_B=Encryption(B,x1,y1,a,b,dimen,key);

after_R=data_loss(after_R,pro,key);
after_G=data_loss(after_G,pro,key);
after_B=data_loss(after_B,pro,key);
after_I=cat(3,after_R,after_G,after_B);

image_name=['en_hu_loss',num2str(pro),'.png'];
en_pathfile=[en_bit_dimen_pathname image_name];
imwrite(after_I,en_pathfile);%保存

re_R=Decryption(after_R,x1,y1,a,b,dimen,key);
re_G=Decryption(after_G,x1,y1,a,b,dimen,key);
re_B=Decryption(after_B,x1,y1,a,b,dimen,key);
re_I=cat(3,re_R,re_G,re_B);
imshow(re_I);

image_name=['re_hu_','loss_',num2str(pro),'.png'];
en_pathfile=[en_bit_dimen_pathname image_name];
imwrite(re_I,en_pathfile);%保存