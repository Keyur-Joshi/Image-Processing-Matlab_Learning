clc
clear all;
I=imread('lena.bmp'); % Read image to memory
imshow(I); title('original image'); % Show image

% apply CANNY edge ditector (threshold = 0.1, sigma = 1) when there is no Gaussian noise.
R=edge(I,'canny',0.1,1); 
%convert reference image into double integer as logical array does not work for immse() function.
ref=im2double(R); figure, subplot(2,3,1),imshow(ref);title('reference image');

% add gaussian noise in original image with mean=0 and variance =0.01
N1=imnoise(I,'gaussian',0,0.01);

% sobel edge detector 
ns1=edge(N1,'sobel'); Ns1=im2double(ns1);
subplot(2,3,2),imshow(Ns1);title('sobel, V=0.01');

% prewitt edge detector
np1=edge(N1,'prewitt'); Np1=im2double(np1);
subplot(2,3,3),imshow(Np1);title('prewitt, V=0.01');

%Laplacian of Gaussian edge detector
nl1=edge(N1,'log'); Nl1=im2double(nl1);
subplot(2,3,4),imshow(Nl1);title('log, V=0.01');

% Canny edge detector
nc1=edge(N1,'canny'); Nc1=im2double(nc1);
subplot(2,3,5),imshow(Nc1);title('canny, V=0.01');

% calculating error with rteference image
error_sobel_1=immse(Ns1,ref)
error_prewitt_1=immse(Np1,ref)
error_Log_1=immse(Nl1,ref)
error_1canny_1=immse(Nc1,ref)