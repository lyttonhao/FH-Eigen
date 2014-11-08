function [ ] = SR_by_PCA( par, El, Eh, mY, mX, X, Vl, Dh )
%reconstruct face images

img_path  = par.test_path;
img_type = par.test_type;
img_dir = dir( fullfile(img_path, img_type) );
img_num = length(img_dir);

for i = 1:img_num
    imHR  =  imread(fullfile( img_path, img_dir(i).name)) ;
    [imHR, imLR] = get_LR( imHR, par );
    [im_h, im_w] = size( imHR );
    
    c = Vl * (El' * (imLR(:) - mY));
    x = real( X * c + mX );
    result = reshape(x, [im_h, im_w]);
    fprintf('No.%d FHE PSNR %2.5f\n', i, csnr(result, imHR,0,0) );
    
    wh = Eh'*(x-mX);
    for j = 1:size(wh, 1)
        if abs(wh(j)) > par.alpha*sqrt(Dh(j,j))
            wh(j) = sign(wh(j))*par.alpha*sqrt(Dh(j,j));
        end
    end
    xh = real( Eh*wh + mX );
    result = reshape(xh, [im_h, im_w]);
    fprintf('No.%d FHE PSNR %2.5f\n', i, csnr(result, imHR,0,0) );
    
    imBicubic = imresize( imLR, par.nFactor, 'Bicubic');
    fprintf('No.%d Bicubic PSNR %2.5f\n', i, csnr(imBicubic, imHR,0,0) );
    
    
    
    imwrite(uint8(result), ['Result/FHE_', img_dir(i).name]);
    imwrite(uint8(result), ['Result/Bicu_', img_dir(i).name]);
    
  
end

end

