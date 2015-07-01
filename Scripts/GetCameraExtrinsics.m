function [ E ] = GetCameraExtrinsics( K )

% Uses pi to derive camera extrinsics (R and t)
% K is class returned by GetCameraExtrinsics

A = K.Kpi(1:3,1:3);
B = K.Kpi(1:3,4);

E.c = -inv(A) * B;
E.R = A * inv(K.Intrinsics);

end

