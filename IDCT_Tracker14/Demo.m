%% Demo.m
% This code is a Matlab implementation of IDCTracker, the tracking algorithm 
% is described in: "Incremental Discriminative Color Object Tracking"
% Author: Alireza Asvadi, Hami Mahdavinataj, MohammadReza Karami and Yasser Baleghi
% Symposium on Artificial Intelligence and Signal Processing (AISP) 2013
% Artificial Intelligence and Signal Processing, Communications in Computer and Information Science,  
% Volume 427,Springer Verlag 2014, pp 71-81. DOI:10.1007/978-3-319-10849-0_8
% Questions regarding the code may be directed to alireza.asvadi@gmail.com
% http://a-asvadi.ir/idct/
%% the options that should be set are:
%  DN    :  folder name of frames, default is 'Basketball'        [line 25]
%  or    :  object region in first frame, set either pre-run      [line 26] 
%           or manually select the object                         [line 37-38] 
%           default for 'Basketball' is [198,214,34,81]
%  sf    :  start frame of tracking, default is 1                 [line 28] 
%  ef    :  end frame of tracking, default is total frame numbers [line 29] 
%  Bin   :  number of bins for each channel, default is 8         [line 32]
%  alpha :  forgetting factor for updating, default is 0.1        [line 33]
%  pct   :  percentage of seeds for updating, default is 0.05     [line 35]
%  Object rectangle and center location are saved in:  
%         [Database Name]R.mat and [Database Name]C.mat           [line 59] (in shw function)
%% clear memory & command window
clc
clear all
close all
%% initialize
DN = 'Basketball'; DR = sprintf('%s%s%s','.', filesep, DN, filesep); % Database name and directory  
or    = [198,214,34,81];                               % Object location in the first frame
tfn   = size(dir(sprintf('%s*.jpg',DR)),1);            % Total Frame Numbers
sf    = 1;                                             % Start Frame For Tracking
ef    = tfn;                                           % End Frame For Tracking
Bin   = 8;                                             % number of bins
alpha = 0.1;                                           % forgetting factor for updating (default 0.1)
pct   = 0.05;                                          % percentage of seeds for updating (default 0.05)
img   = imread(sprintf('%s%04d.jpg',DR,sf));           % Get First Frame
opc   = zeros(ef-sf+1,2);                              % Centroid Locations
opr   = zeros(ef-sf+1,4);                              % Rectangle Locations
% figure(); imshow(img)                                  % Show First Frame & Wait Till Select The Object
% or    = round(getrect(figure(1)));                     % Coded Rect [xmin(col),ymin(row),width,height]
cnt   = round([or(1)+or(3)/2 or(2)+or(4)/2]);          % Object Centroid [col row]
% close Figure 1
%% object/background separation & tracking
for fn = sf:ef

img = imread(sprintf('%s%04d.jpg',DR,fn));             % Read Frame    
[I,Ao,Ab,At] = sarea(img,or,Bin);                      % Search Area & Quantize
%% build object model
if fn == sf
[L,Ln] = llr(I,Ao,Ab,Bin);                             % build object model in the first frame(L is unused)   
end
%% detection & tracking
flg = 1;
mi  = 0;
while flg                                              % mean-shift iteration
mp  = map(I,Ln,At);                                    % detect the object
[cnt,or,mi,flg] = cntd(cnt,or,mi,mp);                  % track the object using mean-shift
end
%% show
[opc,opr] = shw(img,mp,or,cnt,fn,ef,sf,opc,opr,DN);    % show & save output
%% Update object model
[L,Ln]    = upmdl(L,img,or,Bin,alpha,pct);             % update object model(Ln & L are used in map & next update)

end
