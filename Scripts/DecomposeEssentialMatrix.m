function [ Rt2 ] = DecomposeEssentialMatrix( E )

%% Derive Extrinsics of Camera 2 wrt Camera 1
% [Eigenvector, diag(1,1,0) eigenvalue] = single decomposition(Essential Matrix)

[U D V] = svd(E);
%D = [1 0 0; 0 1 0; 0 0 0];

%newE = U*D*V';
%[U D V] = svd(newE);

W = [ 0 -1 0; 1 0 0; 0 0 1];
Wt = [ 0 1 0; -1 0 0; 0 0 1];

R1 = U * W * V';
R2 = U * Wt * V';
T1 = U(1:3,3);
T2 = -U(1:3,3);

% Find correct solution using harley zisserman triangulation

Rt2.R = R1;
Rt2.c = T1;


end

