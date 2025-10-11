file_path =  'I:\Codes\RLID\Visual Safety\Chaos_Paper\chaos\image\differential attack\original image\';% 图像文件夹路径
% en_pathname='I:\Codes\RLID\Visual Safety\chaos\image\differential attack\change_the_first_pixel_encryption\';
en_pathname='I:\Codes\RLID\Visual Safety\Chaos_Paper\chaos\image\differential attack\original encryption\';
img_path_list = dir(strcat(file_path,'*.png'));%获取该文件夹中所有png格式的图像 
img_num = length(img_path_list);%获取图像总数量 
I=cell(1,img_num);
x1=0.2;
y1=0.3;
a=50;
b=50;
key=100;
dimen=32;
% for i=3:1:3
%    dimen=2^(i+2);
%    en_bit_pathname=strcat(en_pathname,['en_helen2\dimen_',num2str(dimen),'\']);
%    if ~exist(en_bit_pathname,'dir')
%      mkdir(en_bit_pathname);
%    end
% end

for i=3:1:3
    dimen=2^(i+2);
%     time_matrix=zeros(1,500);
    %en_bit_dimen_pathname=strcat(en_pathname,['en_helen2\dimen_',num2str(dimen),'\']);
if img_num > 0 %有满足条件的图像
    for j = 1:img_num %逐一读取图像  
        image_name = img_path_list(j).name;% 图像名 
        I =  imread(strcat(file_path,image_name));
        after_R=I(:,:,1);
        after_G=I(:,:,2);
        after_B=I(:,:,3);
        
        %%%%%%%%%改变第一个像素
%         after_R=change_block_pixel(dimen,after_R);
%         after_G=change_block_pixel(dimen,after_G);
%         after_B=change_block_pixel(dimen,after_B);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        for z=1:1:200
            %dimen=32;
            tic;%开始计时
            after_R=Encryption(after_R,x1,y1,a,b,dimen,key);
            after_G=Encryption(after_G,x1,y1,a,b,dimen,key);
            after_B=Encryption(after_B,x1,y1,a,b,dimen,key);
            after_I=cat(3,after_R,after_G,after_B);
            t1=toc;
            if mod(z,25)==0
                before_name=image_name(1:end-4);
                image_na=[before_name,'_round_',num2str(z),'.png'];
                en_pathfile=[en_pathname image_na];
                imwrite(after_I,en_pathfile);
            end
        end
    end
end
end

