function [ K, Rt ] = GetCameraIntrinsicsHartleyZisserman( uv_pts, xyz_pts )

% Uses SVD to solve for K*P and derive the camera intrinsics.
% Follows Hartley and Zissermans calibration method for a single camera

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

% reshape solution x into a 3x4 matrix
K.KP = reshape(x,4,3)';

% Decompose K*P submatrix into K and R and account for the camera look
% direction

[K.K Rt.R] = rq( K.KP(1:3,1:3) )

T = diag(sign(diag(K.K)));
K.K = K.K * T;
Rt.R = T * Rt.R; 

% If the rotation matrix has a negative determinant, negate it.

if( round(det(Rt.R)) == -1 )
    Rt.R = -Rt.R;
end

% Use the new matrix K to derive the camera translation wrt to the world
% origin.

%K.pi = inv(K.Intrinsics)*K.Kpi;
%Rt.T = -inv( K.pi(1:3,1:3) )*K.pi( 1:3,4);

Rt.T = -inv( K.KP(1:3,1:3) )*K.KP( 1:3,4);

end

