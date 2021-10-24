clc
clear
close all
%% loading data

% Fixed Points
movingPoints = readNPY('D:/Projects/Mulakatlar/SaimeKarakus/vr2d.npy');
movingPoints = squeeze(movingPoints);
% Worlds Points
worldPoints = readNPY('D:/Projects/Mulakatlar/SaimeKarakus/vr3d.npy'); % We dont know world coordinates are "normalized or not".
worldPoints = squeeze(worldPoints);

%% Image 1 - PNP 

par.pnp.notrial=1000;  % Number of trial for RPNP 

par.pnp.method='epnp'; % Method of PNP Algorithm

par.undist.do='false'; % There is no undistortion wrt. case

f = 100; % We need to specify the unit of focal length. "World unit" or "pixel unit"?
% I assumed pixel unit.

IntrinsicMatrix = [100 0 0; 0 100 0; 960, 540, 1];
radialDistortion = [0 0]; % There is no distortion, ideal camera
cameraParams = cameraParameters('IntrinsicMatrix',IntrinsicMatrix,'RadialDistortion',radialDistortion); 

cameraPosition = zeros(1,3); % Will be estimated!

cameraPosition = pnp(movingPoints, worldPoints, cameraParams, par);

disp(cameraPosition);
%%




