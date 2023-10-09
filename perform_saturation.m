function x = perform_saturation(x)

% perform_saturation - saturate a vector for better contrast
%
%   x = perform_saturation(x,tau,use_mad);
%
%   tau (around 1) is the saturation factor
%
%   copyright (c) 2007 Gabriel Peyre


tau = 2;
x = x-mean(x(:)); 
x = clamp( x/(2*mad(x(:))), -tau,tau);