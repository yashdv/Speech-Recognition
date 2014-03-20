function m = melFilterBank(p, n, fs)
% Determine matrix for a mel-spaced filterbank
%
% Inputs:       p   number of filters in filterbank
%               n   length of fft
%               fs  sample rate in Hz
%
% Outputs:      x   a (sparse) matrix containing the filterbank amplitudes
%                   size(x) = [p, 1+floor(n/2)]

f0 = 700 / fs;
fn2 = floor(n/2);

lr = log(1 + 0.5/f0) / (p+1);

% convert to fft bin numbers with 0 for DC term
bl = n * (f0 * (exp([0 1 p p+1] * lr) - 1));

b1 = floor(bl(1)) + 1;
b2 = ceil(bl(2));
b3 = floor(bl(3));
b4 = min(fn2, ceil(bl(4))) - 1;

pf = log(1 + (b1:b4)/n/f0) / lr;
fp = floor(pf);
pm = pf - fp;

r = [fp(b2:b4) 1+fp(1:b3)];
c = [b2:b4 1:b3] + 1;
v = 2 * [1-pm(b2:b4) pm(1:b3)];

m = sparse(r, c, v, p, 1+fn2);