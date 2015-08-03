# IDCT
Incremental Discriminative Color Object Tracking

This code is a Matlab implementation of IDCTracker, the tracking algorithm is described in: 
Alireza Asvadi, Hami Mahdavinataj, MohammadReza Karami and Yasser Baleghi,
"Incremental Discriminative Color Object Tracking"
Artificial Intelligence and Signal Processing, Communications in Computer and Information Science, Volume 427, 
Springer Verlag 2014, pp 71-81. DOI:10.1007/978-3-319-10849-0_8

===============================================================================

The code is tested on Windows/Linux with MATLAB R2011a-R2013a.
A test sequence "Basketball" is included so you can simply run Demo.m.
Object rectangle and center location are saved in: [Database Name]R.mat and [Database Name]C.mat.
The functions are:

cntd  - computes centroid

llr   - computes log liklihood ratio

map   - computes object map

prext - prevent rectangle from exiting frames 

sarea - computes search area

shw   - show

upmdl - updates model

================================================================================

Questions regarding the code may be directed to alireza.asvadi@gmail.com

http://a-asvadi.ir/idct/
