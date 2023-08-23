clc;close all;clear 
infilename = '1.jpg';
outfilename = '2.yuv';
RGBimg =imread(infilename);
%figure;imshow(RGBimg);
YUVimg = rgb2ycbcr(RGBimg);     %%% rgb -> yuv
%figure;imshow((YUVimg));
[imgHeight imgWidth imgDim] = size(YUVimg);   %%
len = imgHeight*imgWidth*imgDim;
yuvimout = zeros(1,len);
Y = YUVimg(:,:,1);     % Y 矩阵
U = YUVimg(:,:,2);     % U 矩阵
V = YUVimg(:,:,3);     % V 矩阵
 
R = RGBimg(:,:,1);     % R 矩阵
G = RGBimg(:,:,2);    % G 矩阵
B = RGBimg(:,:,3);     % B 矩阵
 
%Y = 0.257*R+0.504*G+0.098*B+16; 
%V = 0.439*R-0.368*G-0.071*B+128;
%U = -0.148*R-0.291*G+0.439*B+128;
 
len = imgHeight*imgWidth*3/2;
yuv420out = [];
yuv420sampY = Y;
yuv420sampU = U(1:2:size(U,1),1:2:size(U,2));
yuv420sampV = V(2:2:size(V,1),1:2:size(V,2));
[m,n] = size(yuv420sampY);
[m,n] = size(yuv420sampU);
[m,n] = size(yuv420sampV);
 
yuv420sampY = reshape(yuv420sampY',1,[]);
yuv420sampU = reshape(yuv420sampU',1,[]);
yuv420sampV = reshape(yuv420sampV',1,[]);
[m,n] = size(yuv420sampY);
[m,n] = size(yuv420sampU);
[m,n] = size(yuv420sampV);
yuv420sampUV = zeros(1,m*n*2);
yuv420sampUV(1:2:end) = yuv420sampU;%%uv数据交错排列
yuv420sampUV(2:2:end) = yuv420sampV;
[m,n] = size(yuv420sampUV);
yuv420out = [yuv420out reshape(yuv420sampY',1,[])];    %Y 注意要转置
yuv420out = [yuv420out reshape(yuv420sampUV',1,[])];   %VU
%直接拼成YY
%       YY
%       UV
fid= fopen(outfilename,'wb');
    fwrite(fid,yuv420out,'uint8');
fclose(fid);