file_path =  'I:\Codes\RLID\Visual Safety\Chaos_Paper\database\helen\helen_2_change\';% 图像文件夹路径
en_pathname='I:\Codes\RLID\Visual Safety\Chaos_Paper\chaos\image\';
img_path_list = dir(strcat(file_path,'*.png'));%获取该文件夹中所有png格式的图像 
img_num = length(img_path_list);%获取图像总数量 
I=cell(1,img_num);

for i=1:1:4
   dimen=2^(i+2);
   en_bit_pathname=strcat(en_pathname,['en_helen2\dimen_',num2str(dimen),'\']);
   if ~exist(en_bit_pathname,'dir')
     mkdir(en_bit_pathname);
   end
end

for i=1:1:4
    dimen=2^(i+2);
    time_matrix=zeros(1,500);
    en_bit_dimen_pathname=strcat(en_pathname,['en_helen2\dimen_',num2str(dimen),'\']);
if img_num > 0 %有满足条件的图像
    for j = 1:img_num %逐一读取图像  
        image_name = img_path_list(j).name;% 图像名 
        image =  imread(strcat(file_path,image_name));
%         key=100+dimen+j*5;
%         key_seven=10+dimen+j*6;
%         key_per_MSB=1000+dimen+j*7;
%       image=imresize(image, [500 500]);
       R=image(:,:,1);
       G=image(:,:,2);
       B=image(:,:,3);
       tic;%开始计时
       after_R=Encryption(R,x1,y1,a,b,dimen);
       after_G=Encryption(G,x1,y1,a,b,dimen);
       after_B=Encryption(B,x1,y1,a,b,dimen);
       after_I=cat(3,after_R,after_G,after_B);
       en_I=cat(3,after_R,after_G,after_B);
       t1=toc;
       
       
       en_pathfile=[en_bit_dimen_pathname image_name];
       imwrite(en_I,en_pathfile);
       time_matrix(1,j)=t1;
       save(['time_helen_2_dimen_',num2str(dimen)],'time_matrix');
    end
end
end

