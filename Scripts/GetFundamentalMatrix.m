function [ F ] = GetFundamentalMatrix( pts1, pts2 )

% Returns Fundamental Matrix. Left <-> Right

if ( size(pts1,2) ~= 8 || size(pts2,2) ~= 8)
    F = [];
    return;
end

%% Build matrix for solving Fundamental matrix
A=[];
for i=1:8
   
    x=pts1(1,i);
    y=pts1(2,i);
    u=pts2(1,i);
    v=pts2(2,i);
    
    A=[A ;  [x*u x*v x y*u y*v y u v 1] ];
    
end

%% We have a homogeneous linear system Ax=0 need to solve with SVD

[U S V]=svd(A);

% The best solution is the eigenvector corresponding to smallest
% eigenvalue.  This will always be the last column of V in matlab SVD
x=V(:,end);

% reshape solution x into a 3x3 matrix
F=reshape(x,3,3)';

end

