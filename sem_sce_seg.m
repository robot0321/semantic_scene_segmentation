clear; clc; close all;


vis = 1;
img = imread('./train/1_23_s.bmp');
mask = imread('./train/1_23_s_GT.bmp');

%% 1.a) filter bank

filtersize = 11;
filterbank = zeros(filtersize, filtersize,11);

% 3 Gaussians 
filterbank(:,:,1) = fspecial('gaussian', filtersize, 1);
filterbank(:,:,2) = fspecial('gaussian', filtersize, 2);
filterbank(:,:,3) = fspecial('gaussian', filtersize, 4);

% 4 Laplacian of Gaussians
filterbank(:,:,4) = fspecial('log', filtersize, 1);
filterbank(:,:,5) = fspecial('log', filtersize, 2);
filterbank(:,:,6) = fspecial('log', filtersize, 4);
filterbank(:,:,7) = fspecial('log', filtersize, 8);

% 4 Derivative of Gaussians
[Gx2, Gy2] = gradient(filterbank(:,:,2));
filterbank(:,:,8) = Gx2;
filterbank(:,:,9) = Gy2;
[Gx4, Gy4] = gradient(filterbank(:,:,3));
filterbank(:,:,10) = Gx4;
filterbank(:,:,11) = Gy4;

if vis == 1
    figure(1);
    for i=1:11
        if i<=3
            subplot(3,4,i);
        else
            subplot(3,4,i+1);
        end
        surf(1:filtersize, 1:filtersize, filterbank(:,:,i));
    end
end

%% 1.b) texton features - CIE Lab color space

cielab = rgb2lab(img);