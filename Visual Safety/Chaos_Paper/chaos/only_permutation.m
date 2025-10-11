x1=0.2;
y1=0.3;
a=50;
b=50;
dimen=512;

file_path =  'I:\Codes\RLID\Visual Safety\Chaos_Paper\database\helen\helen_2_change\';% 图像文件夹路径
en_pathname='I:\Codes\RLID\Visual Safety\Chaos_Paper\PR3\only-permutation\';
img_path_list = dir(strcat(file_path,'*.png'));%获取该文件夹中所有png格式的图像 
img_num = length(img_path_list);%获取图像总数量 
I=cell(1,img_num);

for i=1:1:100
    image_name = img_path_list(i).name;% 图像名 
    image =  imread(strcat(file_path,image_name));
    R=image(:,:,1);
    G=image(:,:,2);
    B=image(:,:,3);

    for j=1:1:15
        [matrix1,matrix2]=chaos(R,x1,y1,a,b);
        R=P_box(R,dimen,matrix1);
        B=P_box(B,dimen,matrix1);
        G=P_box(G,dimen,matrix1);
    end
    after_I=cat(3,R,G,B);
    en_pathfile=[en_pathname image_name];
    imwrite(after_I,en_pathfile);
end