differental_path =  'I:\Codes\RLID\Visual Safety\chaos\image\differential attack\change_the_first_pixel_encryption\';% 图像文件夹路径
original_path='I:\Codes\RLID\Visual Safety\chaos\image\differential attack\original encryption\';
diff_path_list = dir(strcat(differental_path,'*.png'));%获取该文件夹中所有png格式的图像 
orig_path_list = dir(strcat(original_path,'*.png'));%获取该文件夹中所有png格式的图像 
img_num = length(diff_path_list);%获取图像总数量 
naci_matrix=zeros(1,24);
npcr_matrix=zeros(1,24);
for j=1:1:img_num
    image_name = diff_path_list(j).name;% 图像名 
    diff_I =  imread(strcat(differental_path,image_name));
    orig_I =  imread(strcat(original_path,image_name));
    
    results = NPCR_and_UACI( diff_I, orig_I);
    npcr=results.npcr_score;
    naci=results.uaci_score;
    naci_matrix(1,j)=naci;
    npcr_matrix(1,j)=npcr;
end