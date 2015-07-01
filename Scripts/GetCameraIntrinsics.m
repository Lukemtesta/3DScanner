function [ K ] = GetCameraIntrinsics( uv_pts, xyz_pts )

% Uses SVD to solve for pi and derive the camera intrinsics.
% Follows CVPR lecture 25

% Requires 6 keypoints in image (uv_pts) and their respective world 
% positions (xyz_pts).

if( size(uv_pts,2) ~= 6 || size(xyz_pts,2) ~= 6 )
   K = [];
   return;
end

A = [];

for i=1:6
    
    x = xyz_pts(1,i);
    y = xyz_pts(2,i);
    z = xyz_pts(3,i);
    u = uv_pts(1,i);
    v = uv_pts(2,i);
    
    A = [A; x y z 1 0 0 0 0 (-u*x) (-u*y) (-u*z) -u];
    A = [A; 0 0 0 0 x y z 1 (-v*x) (-v*y) (-v*z) -v];
    
end

% Solve unknowns using SVD

[U S V]=svd(A);

% The best solution is the eigenvector corresponding to smallest
% eigenvalue.  This will always be the last column of V in matlab SVD
x=V(:,end);

% reshape solution x into a 3x3 matrix
K.Kpi = reshape(x,4,3)';

% derive camera intrinsics

q1 = [K.Kpi(1,1), K.Kpi(1,2), K.Kpi(1,3)]';
q2 = [K.Kpi(2,1), K.Kpi(2,2), K.Kpi(2,3)]';
q3 = [K.Kpi(3,1), K.Kpi(3,2), K.Kpi(3,3)]';
q4 = [K.Kpi(1,4), K.Kpi(2,4), K.Kpi(3,4)]';

cx = q1'*q3; 
cy = q2'*q3;
fx = sqrt( (q1'*q1) - (cx^2) ); 
fy = sqrt( (q2'*q2) - (cy^2) );

K.Intrinsics = [ fx, 0, cx; 0 fy cy; 0 0 1];

end

