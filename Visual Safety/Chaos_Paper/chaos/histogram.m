%直方图
I=imread('diff_baboon_round_25_32.png');
% I1=imread('G:\paper-ruoyu\chaos\image\encyption round\xian_1.png');
% I10=imread('G:\paper-ruoyu\chaos\image\encyption round\xian_10.png');
% I50=imread('G:\paper-ruoyu\chaos\image\encyption round\xian_50.png');
% I75=imread('G:\paper-ruoyu\chaos\image\encyption round\xian_75.png');
% I100=imread('G:\paper-ruoyu\chaos\image\encyption round\xian_100.png');
% i=3;

R=I(:,:,1);
R1=I(:,:,2);
R10=I(:,:,3);
% R50=I50(:,:,i);
% R75=I75(:,:,i);
% R100=I100(:,:,i);

subplot(1,3,1)
% title('Original image');
imhist(R);
title('R');

subplot(1,3,2)
imhist(R1);
title('G');

subplot(1,3,3)
imhist(R10);
title('B');

% subplot(2,3,1)
% % title('Original image');
% imhist(R);
% title('Original image');
% 
% subplot(2,3,2)
% imhist(R1);
% title('Round 1');
% 
% subplot(2,3,3)
% imhist(R10);
% title('Round 10');
% 
% 
% subplot(2,3,4)
% imhist(R50);
% title('Round 50');
% 
% 
% subplot(2,3,5)
% imhist(R75);
% title('Round 75');
% 
% subplot(2,3,6)
% imhist(R100);
% title('Round 100');