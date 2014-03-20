function c = mfcc(s, fs)
% MFCC Calculate the mel frequencey cepstrum coefficients (MFCC) of a signal
%
% Inputs:
%       s       : speech signal
%       fs      : sample rate in Hz
%
% Outputs:
%       c       : MFCC output, each column contains the MFCC's for one speech frame

N = 256;                        % frame size
M = 100;                        % inter frame distance
len = length(s);
numberOfFrames = 1 + floor((len - N)/double(M));
mat = zeros(N, numberOfFrames); % vector of frame vectors

for i=1:numberOfFrames
    index = 100*(i-1) + 1;
    for j=1:N
        mat(j,i) = s(index);
        index = index + 1;
    end
end

hamW = hamming(N);              % hamming window
afterWinMat = diag(hamW)*mat;   
freqDomMat = fft(afterWinMat);  % FFT into freq domain

filterBankMat = melFilterBank(20, N, fs);                % matrix for a mel-spaced filterbank
nby2 = 1 + floor(N/2);
ms = filterBankMat*abs(freqDomMat(1:nby2,:)).^2; % mel spectrum
c = dct(log(ms));                                % mel-frequency cepstrum coefficients
c(1,:) = [];                                     % exclude 0'th order cepstral coefficient