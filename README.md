# IDCT
Incremental Discriminative Color Object Tracking

A method for tracking an object in a sequence of images given its location in the first frame. A combination of generative and discriminative methods is used to model the object appearance. It is used to provide a right balance between being adaptive and ability to re-track the object after losing the object due to occlusion. The quantized 3D joint RGB histograms of the region within the inner rectangle and the region between the inner and outer rectangles are used as a discriminative component. The generative component is composed of the positive part of the log-likelihood ratio of the computed 3D joint RGB histograms along with an incremental color learning scheme with a forgetting factor. In every frame, after localization, discriminative component differentiates the object from its surrounding background and adds the detected object colors to the generative model. The generative model is evolved during tracking and is used to detect the object in the next frame. This code is a Matlab implementation of IDCTracker, the full tracking algorithm is described in: 
Alireza Asvadi, Hami Mahdavinataj, MohammadReza Karami and Yasser Baleghi,
"Incremental Discriminative Color Object Tracking"
Artificial Intelligence and Signal Processing, Communications in Computer and Information Science, Volume 427, 
Springer Verlag 2014, pp 71-81. DOI:10.1007/978-3-319-10849-0_8

Watch the result in the video below.
https://youtu.be/tMy32yix-8s

The code is tested on Windows/Linux with MATLAB R2011a-R2013a. A test sequence "Basketball" is included so you can simply run Demo.m.
Object rectangle and center location are saved in: R.mat and C.mat. The functions are:

cntd  - computes centroid

llr   - computes log liklihood ratio

map   - computes object map

prext - prevent rectangle from exiting frames 

sarea - computes search area

shw   - show

upmdl - updates model

http://a-asvadi.ir/idct/
