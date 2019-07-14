# Huawei Image Denoising Competition (UK Challenge 1 Nov to 30 Nov 2018) #
http://eucompetition.huawei.com/uk/ 
 
## Competition details ##
Participants were required to develop an algorithm that reduces image noise whilst preserving image detail. 

We were provided a training dataset containing image pairs of 975 noisy images and their corresponding clean images, which were captured using Huawei P20 smart phones across the image classes ‘buildings’, ‘text’ and ‘foliage’, together with a CSV file providing meta-data for each sample such as the ISO setting. 

Then, participants had to use their codes to denoise 30 noisy unseen test images (10 from each image class) without having their corresponding clean images, and these denoised images were then submitted onto the competition website. The effectiveness of the algorithm was evaluated using PSNR and SSIM by the organisers.
 
## Demo ##
**Gaussian Blur, Bilateral Filtering, Non-local means denoising:**
Jupyter notebook demonstrates opencv implementations of these methods using a sample from the huawei competition. (Requires downloading of opencv 3)

**BM3D:**
In the folder BM3D_COLOR, run the *run.m* file in Matlab, which will denoise the 30 images in the *test* folder provided by huawei and save the outputs in the *output* folder. The matlab code is extracted from http://www.cs.tut.fi/~foi/GCF-BM3D/ 
 
## Results ##
|Submitted test  images| PSNR| SSIM|
|----------------------|------|---------|
Original | 38.56| 0.661|
BM3D denoised| 40.89| 0.651|
 
## Learning Experience ##
Having no prior knowledge in the field of image denoising, I first tried out libraries such as opencv and scikit-image. Basic functions like Gaussian Blur, bilateral filtering, and non-local means denoising were tried. They produced mediocre results on the given images because the given noisy images were only slightly corrupted, and the filtering ended up blurring the images more than noise was removed.
 
I then proceeded to read about state-of-the-art image denoising techniques and encountered a github repository documenting such techniques with their respective codes uploaded online: https://github.com/wenbihan/reproducible-image-denoising-state-of-the-art. However, most of the papers were beyond my understanding in that scope of time. But I was still able to implement some of the codes, such as BM3D and DnCNN. My attempt to train DnCNN using the given codes was a failure because my GPU did not have enough memory, and using the pretrained model didn’t give good results, presumably because the Huawei image dataset had a much better PSNR than the ones that were used by the researchers.
 
The BM3D method proved to be the most successful out of the methods that I tried.
 
## Brief description of each method tried ##
### Gaussian Blur: https://docs.opencv.org/3.1.0/d4/d13/tutorial_py_filtering.html ###
Noise is typically high frequency and applying a low pass filter on the image ‘smooths’ the image and removes noise to some extent. This is done by convolving a low-pass filter kernel with the image, so that the weighted average of the neighbourhood around each pixel is taken. Such a kernel can be chosen to be Gaussian distributed with a predefined standard deviation and size, and will be very effective if noise is assumed to be Gaussian.

### Bilateral Filtering: https://docs.opencv.org/3.1.0/d4/d13/tutorial_py_filtering.html ###
The Gaussian Blur does not distinguish between edges and non-edges while the bilateral filter preserves edges when removing noise, since it is a Gaussian filter of both space and pixel intensity difference.

### Non-local means denoising: https://docs.opencv.org/3.2.0/d5/d69/tutorial_py_non_local_means.html ###
The Gaussian and bilateral filters merely work locally around the neighbourhood of each pixel. However, natural images contain many similar patches located far away from each other. This is exploited by non-local means denoising, which identifies all similar patches to the current patch observed, and replacing the centre pixel with the average of all these similar patches.

### BM3D (Block-Matching and 3D Filtering): http://www.cs.tut.fi/~foi/GCF-BM3D/ ###
Similar to non-local means denoising, similar 2D patches are found, but this time grouped together to form 3D arrays called blocks. A special type of filtering called collaborative filtering is then applied to all the 3D blocks, which are then transformed back to the original image. And because the blocks are overlapping, each pixel will have a number of estimates, and aggregation is a special averaging procedure to obtain the denoised pixel value.

 
## Further things to do: ##
I would try to write out the codes for implementing the simpler techniques myself, such as Bilateral Filtering, non-local means and BM3D. If possible I would want to properly train a CNN to denoise images as well. In general, I do not have a good understanding on the field of digital image denoising and I would like to get a more comprehensive overview, such as the nature of noise and what method is suitable for what kind of noise etc.
