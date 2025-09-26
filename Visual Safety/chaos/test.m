x1=0.2;
y1=0.3;
a=50;
b=50;
key=10000;
%dimen=8;
I=imread('PR3_major_3.png');
en_bit_dimen_pathname='I:\Codes\RLID_Sprout\Visual Safety\chaos\';

after_R=I(:,:,1);
after_G=I(:,:,2);
after_B=I(:,:,3);
for j=1:1:4
    dimen=2^(j+2);
for i=1:1:1
    %dimen=32;
    tic;%开始计时
    after_R=Encryption(after_R,x1,y1,a,b,dimen,key);
    after_G=Encryption(after_G,x1,y1,a,b,dimen,key);
    after_B=Encryption(after_B,x1,y1,a,b,dimen,key);
    after_I=cat(3,after_R,after_G,after_B);
    t1=toc;
    image_name=['PR3_major_3_dimen',num2str(dimen),'.png'];
    en_pathfile=[en_bit_dimen_pathname image_name];
    
    imwrite(after_I,en_pathfile);
end
end
% key1=10002;
% re_R=Decryption(after_R,x1,y1,a,b,dimen,key1);
% re_G=Decryption(after_G,x1,y1,a,b,dimen,key1);
% re_B=Decryption(after_B,x1,y1,a,b,dimen,key1);
% re_I=cat(3,re_R,re_G,re_B);
% image_name=['gugong_re_',num2str(dimen),'_enkey_',num2str(key),'_rekey_',num2str(key1),'.png'];
% en_pathfile=[en_bit_dimen_pathname image_name];
% imwrite(re_I,en_pathfile);
%re_I=De_I(after_I,dimen,x1,y1,a,b);






