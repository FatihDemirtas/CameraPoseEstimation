# CameraPoseEstimation
Pose Estimation from images taken from same camera

To estimate camera pose, there are generally two approach.
1. Using techniques such as "Keypoint detection", "Feature Extraction", "Feature Matching", "PNP"
2. Using directly 2D-3D corresponding pixels between reference and moving image.

In the given case, 
There are 3 images & 2D-3D corresponding points. But there is no clear explanation about units and 2D-3D points.

For example, 
* What is the unit of focal length? In world coordinate system or pixel coordinate system?
* Which two images have 2D-3D correspondence between? Image 1 & Image2? or Image 1 & Image 3?
* What is the pixel lenght? How can we convert focal lenght to world coordinates?

Because of these uncertainties, I tried 2 approach. 
1. Using_2D_3D_Correspondance
2. Using_Feature_Extraction
![12](https://user-images.githubusercontent.com/50075805/138609706-a12703b2-3f2d-4970-b67e-ac412aa5df1c.png)
![13](https://user-images.githubusercontent.com/50075805/138609710-7b2d299e-ea23-44c8-a797-cb57a6ac17d8.png)


I want to express that camera pose estimation is my original field. I published some academic papers about that. I aslo worked on camera pose estimation from UAV images under GNSS absence. To find a UAV location, we use the same approach like camera pose estimation. Using reference orthophotos, we calculated camera pose from images taken from UAV.

I am sharing my conference papers in this github repository. 

1. [COMPARISON OF IMAGE MATCHING ALGORITHMS ON SATELLITE IMAGES TAKEN IN DIFFERENT SEASONS (1).pdf](https://github.com/FatihDemirtas/CameraPoseEstimation/files/7406114/COMPARISON.OF.IMAGE.MATCHING.ALGORITHMS.ON.SATELLITE.IMAGES.TAKEN.IN.DIFFERENT.SEASONS.1.pdf)

2. [A METHOD TO ENHANCE HOMOGENEOUS DISTRIBUTION OF MATCHED FEATURES FOR IMAGE MATCHING (1).pdf](https://github.com/FatihDemirtas/CameraPoseEstimation/files/7406115/A.METHOD.TO.ENHANCE.HOMOGENEOUS.DISTRIBUTION.OF.MATCHED.FEATURES.FOR.IMAGE.MATCHING.1.pdf)

3. [INVESTIGATION OF THE EFFECTS OF FALSE MATCHES AND DISTRIBUTION OF THE MATCHED KEYPOINTS ON THE PNP ALGORITHM (1).pdf](https://github.com/FatihDemirtas/CameraPoseEstimation/files/7406116/INVESTIGATION.OF.THE.EFFECTS.OF.FALSE.MATCHES.AND.DISTRIBUTION.OF.THE.MATCHED.KEYPOINTS.ON.THE.PNP.ALGORITHM.1.pdf)

