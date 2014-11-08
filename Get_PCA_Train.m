function [El, Eh, mY, mX, Y, X, Vl, Dh] = Get_PCA_Train( par )
%calculate PCA of training faces 

img_path  = par.train_path;
img_type = par.train_type;
img_dir = dir( fullfile(img_path, img_type) );
%load( 'Data/train3.mat');

X = [];
Y = [];
img_num = length(img_dir);
%img_num = size(images_hr, 3);
for i = 1 : img_num
    imHR  =  imread(fullfile( img_path, img_dir(i).name)) ;
   % imHR = images_hr(:,:,i);
    [imHR, imLR] = get_LR( imHR, par );
    Y(:, i) = imLR(:); 
    X(:, i) = imHR(:);
end
mY = mean(Y, 2);
mX = mean(X, 2);
Y = Y - repmat(mY, [1, img_num]);
X = X - repmat(mX, [1, img_num]);

%calculate PCA coefficent
[El, Eh, Dl, Dh, Vl] = cal_PCA( double(Y), double(X) );


    
end