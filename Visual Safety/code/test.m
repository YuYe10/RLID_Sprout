keyFile = "D:/paper-ruoyu/3D/Hierarchical_Decryption-main/_Key_List.txt";
key_vec = importdata(keyFile);%文件中的每一行都是64位16进制，也就是256位bit

%dimen=8;
I=imread('111.png');
% en_bit_dimen_pathname='D:\paper-ruoyu\别人论文\苏老师论文\paper4\code\video\';
% I_name=[en_bit_dimen_pathname,'frame10.png'];
% 
% I=imread(I_name);

R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);
% R(1,1)=0;
for j=9:1:9
    dimen=2^(j);
    key=key_vec{1,1};%取出一个主密钥
    key=char(key);
for i=1:1:1
    %dimen=32;
    tic;%开始计时
    [key,after_R]=Encryption(R,dimen,key);
    [key,after_G]=Encryption(G,dimen,key);
    [key,after_B]=Encryption(B,dimen,key);
    after_I=cat(3,after_R,after_G,after_B);
    t1=toc;
    image_name=['111_',num2str(dimen),'.png'];
    
    imwrite(after_I,image_name);

% %     key="357538782F413F4428472B4B6250655368566D59703373367639792442264528";
% %     key=char(key);
%     key=key_vec{1,1};%取出一个主密钥
%     key=char(key);
%     
% 
%     [key,re_R]=Decryption(after_R,dimen,key);
%     [key,re_G]=Decryption(after_G,dimen,key);
%     [key,re_B]=Decryption(after_B,dimen,key);
%     re_I=cat(3,re_R,re_G,re_B);
%     image_name=['de_111_',num2str(dimen),'_sen.png'];
%     imwrite(re_I,image_name);
end
end

% key_vec = importdata(keyFile);%文件中的每一行都是64位16进制，也就是256位bit
% key=key_vec{1,1};%取出一个主密钥
% 
% for j=3:1:6
%     dimen=2^(j);
% %     key=key_vec{1,1};%取出一个主密钥
% %     key=char(key);
% key="357538782F413F4428472B4B6250655368566D59703373367639792442264528";
% for i=1:1:1
% 
% 
% [key,re_R]=Decryption(after_R,dimen,key);
% [key,re_G]=Decryption(after_G,dimen,key);
% [key,re_B]=Decryption(after_B,dimen,key);
% re_I=cat(3,re_R,re_G,re_B);
% image_name=['de_111_',num2str(dimen),'_sen.png'];
% imwrite(re_I,image_name);
% end
% end






