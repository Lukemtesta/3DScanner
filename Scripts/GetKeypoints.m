function [ uv_calpoints, xyz_calpoints ] = GetKeypoints( imgName, N )

% Returns Selected Keypoints (N) of Frame using HCD

% Load Calibration Image

bothimg = imread(imgName);
imshow(bothimg);

% Find control points as harris corners

bothimg = rgb2gray(bothimg);
keypoints = torr_charris_jc(bothimg);

% Select 12 points in each image to derive pi.

disp(['Select ' num2str(N) ' points to calibrate camera 1s intrinsics'])
uv_calpoints = [];

for i=1:N
   disp([ 'Point ' num2str(i) ])
   [x y] = ginput(1);
   
   % Quantise selected pixel to nearest harris keypoint
   kp = repmat([x; y], 1, size(keypoints,1) )';
   kp = keypoints - kp;
   dist = sqrt( kp(:,1).^2 + kp(:,2).^2 );
   [Val Ind] = min(dist);
   
   uv_calpoints = [uv_calpoints, [keypoints(Ind,1); keypoints(Ind,2)] ]
end

xyz_calpoints = [ [-1;  0.5;  -5], [0;  0.5;  -5], [-1;  -0.5;  -5;], ...
                    [0;  -0.5;  -5] ];
xyz_calpoints = [ xyz_calpoints, [1;  0.5;  -5], [2;  0.5;  -5], ... 
                    [1;  -0.5;  -5;], [2;  -0.5;  -5] ] ;

hold on
scatter( uv_calpoints(1,:), uv_calpoints(2,:), 'rx' )


end

