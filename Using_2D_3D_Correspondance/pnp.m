function cameraPosition=pnp(movingPoints,worldPoints,cameraParams,par)

pixel_lenght = 3.45; % mm % We need to specify the pixel lenght. There is no information in the case explanation!

% 3d points
ft=worldPoints;

% image points, pixel (column, row)
im_pt = movingPoints;

if par.undist.do
im_pt = undistortPoints(im_pt,cameraParams);
end

% shift the origin to a local point temporarily
org_nh= [447800,4470200, 1000];

% shift the 3d points to the local origin
ft = ft - ones(size(worldPoints, 1), 1) * org_nh;

% convert image points to normalized camera coordinates
% j->x, i->y, boresight->z
ft_im=(im_pt-[cameraParams.PrincipalPoint(1)/2,cameraParams.PrincipalPoint(2)/2])/(cameraParams.FocalLength(1)*1000/pixel_lenght);

cameraPosition=zeros(par.pnp.notrial,3);
    % PnP
     for j=1:par.pnp.notrial
         switch par.pnp.method
           case 'rpnp' 
                [rot, tran] = RPnP(ft', ft_im');
           case 'lhm'
                [rot, tran] = LHM(ft', ft_im');
           case 'epnp'
                [rot, tran] = EPnP(ft', ft_im');
           case 'dlt'
                [rot, tran] = DLT(ft', ft_im');
           otherwise 
                disp('Enter a valid PNP algorithm'); 
         end
      % convert the camera center to 3d coordinate system
         tran2 = rot\([0 0 0]' - tran);

      % camera origin, from local origin to world coordinates
         cameraPosition(j,:) = tran2' + org_nh;

     end
    
cameraPosition=sum(cameraPosition)/par.pnp.notrial;

end