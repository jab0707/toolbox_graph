function M = compute_rotation(v,alpha)

% compute the 3D rotation matrix around vector v
%   and with angle alpha.
%
%   M = compute_rotation(v,alpha)
%
%   Copyright (c) 2004 Gabriel Peyré

v = reshape(v,3,1);

d = v'*v;
if d < 1.0e-10
    M = eye(3);    
else
    v = v/d^0.5;
    S = [ 0   -v(3) v(2);
         v(3)  0   -v(1);
        -v(2)  v(1) 0];
    M = v*v' + cos(alpha)*(eye(3) - v*v') + sin(alpha)*S;
end


