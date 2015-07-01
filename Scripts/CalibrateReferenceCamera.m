
%% Derive Camera Intrinsics for Reference Camera

[uv_calpoints xyz_calpoints] = GetKeypoints('canvas1.png',6);
xyz_calpoints = xyz_calpoints(1:3,1:6);

[K Rt] = GetCameraIntrinsicsHartleyZisserman(uv_calpoints, xyz_calpoints);

% Obtain Projection Matrix, M, to compare with original projection matrix

P = [Rt.R,Rt.T];
M = K.K * P;

K.KP            % derivation
M               % Reproduced


%% Compute Reprojection Error

p = [uv_calpoints(1:2)  1];
pn = ProjectionMap( inv(K.Intrinsics), p );   % NCC point for image 1

worldpt = [-1 0.5 5 1];
q = ProjectionMap( M, worldpt );

ProjectionError = (q(1) - p(1) )^2 + (q(2) - p(2) )^2



%% Derive Fundamental Matrix wrt to camera 1

% Select 8 corresponding points

[uv_calpoints xyz_calpoints] = GetKeypoints('canvas1.png',8);
[uv_corrpoints xyz_corrpoints] = GetKeypoints('canvas2.png',8);

% Derive Fundamental matrix and camera 2 extrinsics wrt to camera 1

F = GetFundamentalMatrix(uv_calpoints, uv_corrpoints);
E = GetEssentialMatrix( K, F );
Rt2 = DecomposeEssentialMatrix( E );


%% Compute reprojection error

%% Find Corresponding Points for pixels between viewpoints.

%% Divide space into visual hull

%% Compute and find voxel at which rays intersect
