x1=0.2;
y1=0.3;
a=50;
b=50;
key=10000;
dimen=32;
I=imread("PR3_major_3.png");
en_bit_dimen_pathname='I:\Codes\RLID\Visual Safety\Chaos_Paper\chaos\';
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);

%加密

after_R=Encryption(R,x1,y1,a,b,dimen,key);
after_G=Encryption(G,x1,y1,a,b,dimen,key);
after_B=Encryption(B,x1,y1,a,b,dimen,key);

after_I=cat(3,after_R,after_G,after_B);

image_name=['PR3_en_key_',num2str(key),'.png'];
en_pathfile=[en_bit_dimen_pathname image_name];
imwrite(after_I,en_pathfile);%保存

%解密

key1=10000;

re_R=Decryption(after_R,x1,y1,a,b,dimen,key1);
re_G=Decryption(after_G,x1,y1,a,b,dimen,key1);
re_B=Decryption(after_B,x1,y1,a,b,dimen,key1);
re_I=cat(3,re_R,re_G,re_B);

% imshow(re_I);

image_name=['PR3_en_key_',num2str(key),'_re_key_',num2str(key1),'.png'];
en_pathfile=[en_bit_dimen_pathname image_name];
imwrite(re_I,en_pathfile);%保存