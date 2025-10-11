I1=imread('Copy_of_PR3_major_3_dimen16.png');
I2=imread('PR3_major_3_dimen16.png');
I3=double(I1)-double(I2);

dimen=32;
after_R=uint8(abs(I3(:,:,1)));
after_G=uint8(abs(I3(:,:,2)));
after_B=uint8(abs(I3(:,:,3)));
after_I=cat(3,after_R,after_G,after_B);
en_bit_dimen_pathname='I:\Codes\RLID\Visual Safety\Chaos_Paper\chaos\';
image_name=['diff_baboon_round_25_',num2str(dimen),'.png'];
en_pathfile=[en_bit_dimen_pathname image_name];
imwrite(after_I,en_pathfile);
%imshow(after_R);