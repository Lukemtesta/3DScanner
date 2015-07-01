function [ E ] = GetEssentialMatrix( K, F )

E = K.Intrinsics' * F * K.Intrinsics;

end

