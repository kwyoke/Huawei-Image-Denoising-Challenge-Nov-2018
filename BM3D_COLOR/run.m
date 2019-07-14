path = '../test/'; %directory containing images to be denoised
files = dir (strcat(path,'*.png')); %assuming images are png files
output_folder = 'output/';

L = length (files);

for i=1:L 
   % process the image in here
   % Read an RGB image and scale its intensities in range [0,1]
   yRGB = im2double(imread(strcat(path, files(i).name))); 
   % Generate the same seed used in the experimental results of [1]
   randn('seed', 0);
   % Standard deviation of the noise --- corresponding to intensity 
   %  range [0,255], despite that the input was scaled in [0,1]
   sigma = 10;
   % Add the AWGN with zero mean and standard deviation 'sigma'
   zRGB = yRGB + (sigma/255)*randn(size(yRGB));
   % Denoise 'zRGB'. The denoised image is 'yRGB_est', and 'NA = 1'  
   %  because the true image was not provided
   [NA, yRGB_est] = CBM3D(1, zRGB, sigma); 
   imwrite(min(max(yRGB_est,0),1), strcat(output_folder, files(i).name));
   disp(i);
   
end 

