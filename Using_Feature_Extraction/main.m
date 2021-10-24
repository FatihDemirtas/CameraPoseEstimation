%% Load & convert images

img1 = rgb2gray(imread("./img1.png"));
img2 = rgb2gray(imread("./img2.png"));
img3 = rgb2gray(imread("./img3.png"));

%% Detect Keypoints

keypoints1 = detectKAZEFeatures(img1, 'NumScaleLevels', 3, ...
                                'NumOctaves', 3, ...
                                'Threshold', 0.001, ...
                                'Diffusion', "region");
                            
                            
keypoints2 = detectKAZEFeatures(img2, 'NumScaleLevels', 3, ...
                                'NumOctaves', 3, ...
                                'Threshold', 0.001, ...
                                'Diffusion', "region");
                            
                            
keypoints3 = detectKAZEFeatures(img3, 'NumScaleLevels', 3, ...
                                'NumOctaves', 3, ...
                                'Threshold', 0.001, ...
                                'Diffusion', "region");
%% Select Strongests
N = 1500; 

sel_keypoints1 = selectUniform(keypoints1, N, size(img1));
sel_keypoints2 = selectUniform(keypoints2, N, size(img2));
sel_keypoints3 = selectUniform(keypoints3, N, size(img3));

%% There is no distortion in the camera wrt. case. If exists, we need to undistort keypoint locations.

%% Extract Features

[features1, valid1] = extractFeatures(img1, sel_keypoints1,'Method','KAZE',...
                                                           'FeatureSize',64,...
                                                           'Upright', false);
                                                
[features2, valid2] = extractFeatures(img2, sel_keypoints2,'Method','KAZE',...
                                                           'FeatureSize',64,...
                                                           'Upright', false);

[features3, valid3] = extractFeatures(img3, sel_keypoints3,'Method','KAZE',...
                                                           'FeatureSize',64,...
                                                           'Upright', false);  
                                                       
%% Matching Features

%Match image1 and image2 features
indexPairs_12 = matchFeatures(features1,features2);

matchedPoints12 = valid1(indexPairs_12(:,1),:);
matchedPoints2 = valid2(indexPairs_12(:,2),:);
figure(1); showMatchedFeatures(img1, img2, matchedPoints12,matchedPoints2,'montage')                                                

%------------------------------------------------------------------------
%Match image1 and image3 features
indexPairs_13 = matchFeatures(features1, features3);

matchedPoints13 = valid1(indexPairs_13(:,1),:);
matchedPoints3 = valid3(indexPairs_13(:,2),:);
figure(2); showMatchedFeatures(img1, img3, matchedPoints13,matchedPoints3,'montage')  

%% Find Outliers - Estimate Geometric Transform

[~,inlierpoints12, inlierpoints2] = estimateGeometricTransform(matchedPoints12, matchedPoints2,...
        'projective', 'Confidence', 90, 'MaxNumTrials', 1000);

[~,inlierpoints13, inlierpoints3] = estimateGeometricTransform(matchedPoints13, matchedPoints3,...
        'projective', 'Confidence', 90, 'MaxNumTrials', 1000);

%% Find Inliers - Estimate Fundamental Martix

[f_matrix_12,inliers_fundamental_12] = estimateFundamentalMatrix(matchedPoints12, matchedPoints2,...
        'Method','RANSAC', 'NumTrials',2000)

[f_matrix_13,inliers_fundamental_13] = estimateFundamentalMatrix(matchedPoints13, matchedPoints3,...
        'Method','RANSAC', 'NumTrials',2000)
    
    
%% Fit Geotrans

tform_12 = fitgeotrans(inlierpoints12.Location, inlierpoints2.Location,'pwl');
tform_13 = fitgeotrans(inlierpoints13.Location, inlierpoints3.Location,'pwl');

%% Image Warping

img1_fixed = imref2d(size(img1));

warpedImage_12 = imwarp(img2, tform_12, 'OutputView', img1_fixed);
warpedImage_13 = imwarp(img3, tform_13, 'OutputView', img1_fixed);

figure(3); imshowpair(img1,warpedImage_12,'blend')
figure(4); imshowpair(img1,warpedImage_13,'blend')

%% After finding corresponding features, We need to know elevation of reference image pixels. 
%% With adding elevation information to keypoints, We can find camera pose with respect to reference image.
