function [ P ] = Homography( p, q )

% Compute perspective matrix using 4-point homography

if ( size(p,2) ~= 4 || size(q,2) ~= 4 )
    F = [];
    return;
end

%% Build matrix for solving Fundamental matrix
A=[];
for i=1:4
   
    A=[A ; [p(1,i) p(2,i) 1 0 0 0 -p(1,i)*q(1,i) -p(2,i)*q(1,i) -q(1,i)] ];
    A=[A ; [0 0 0 p(1,i) p(2,i) 1 -p(1,i)*q(2,i) -p(2,i)*q(2,i) -q(2,i)] ];
    
end

%% We have a homogeneous linear system Ax=0 need to solve with SVD

[U S V]=svd(A);

% The best solution is the eigenvector corresponding to smallest
% eigenvalue.  This will always be the last column of V in matlab SVD
x=V(:,end);

% reshape solution x into a 3x3 matrix
P=reshape(x,3,3)';

end

