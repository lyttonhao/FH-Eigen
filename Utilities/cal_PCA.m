function [El, Eh, Dl, Dh, Vl] = cal_PCA( Y, X )
%get PCA for large dimensions
    [V, Dl] = eig( Y'*Y );
    El = Y * V * Dl^(-0.5);
    Vl = V * Dl^(-0.5);   
    
    [V, Dh] = eig( X'*X );
    Eh = X * V * Dh^(-0.5);
end