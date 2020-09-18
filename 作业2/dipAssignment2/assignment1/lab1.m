% 1.read image, calculate P Q
f = imread('436.tif');
%f=imread('woman.png');
[M, N] = size(f);
subplot(2,4,1);
imshow(f);
title('Ô­Í¼Ïñ');
P = 2*M; Q = 2*N;

% 2.get the image after filling
% fp is a double matrix, or there will be no minus after translation
fp = zeros(P,Q);
fp(1:M,1:N) = f(1:M,1:N);
img_b = uint8(fp);
subplot(2,4,2);
imshow(img_b);
title('0Ìî³ä');
imwrite(img_b, 'b.tif');

% 3. translate fp
% fpt means fp translation
fpt = zeros(P,Q);
for i = 1:M
    for j = 1:N
        fpt(i,j) = fp(i,j)*((-1)^(i+j));
    end
end
img_c = uint8(fpt);
subplot(2,4,3);
imshow(img_c);
title('Æ½ÒÆ');
imwrite(img_c,'c.tif');

% 4. DFT, get F
F = fft2(fpt, P, Q);
spectrum1 = getSpectrum(F);
img_d = uint8(normalize(spectrum1,0,255));
subplot(2,4,4);
imshow(img_d);
title('¸µÀïÒ¶Æ×');
imwrite(img_d, 'd.tif');

% 5. make filter H
H = zeros(P,Q);
% D0 needs to be set manually
D0 = 20; 
for i = 1:P
   for j = 1:Q
       H(i,j) = exp(-((i-M)^2+(j-N)^2) / (2*D0^2));
   end
end
img_e = uint8(normalize(H,0,255));
subplot(2,4,5);
imshow(img_e);
title('¸ßË¹µÍÍ¨ÂË²¨Æ÷');
imwrite(img_e, 'e.tif');

% 6.
G = H.*F;
spectrum2 = getSpectrum(G);
img_f = uint8(normalize(spectrum2,0,255));
subplot(2,4,6);
imshow(img_f);
title('ÂË²¨ºóµÄ¸µÀïÒ¶Æ×');
imwrite(img_f,'f.tif');
% gbt means fp after translation
gbt = real(ifft2(G));
gp = zeros(P,Q);
for i = 1:M
    for j = 1:N
        gp(i,j) = gbt(i,j)*(-1)^(i+j);
    end
end
img_g = uint8(gp);
subplot(2,4,7);
imshow(img_g);
title('ÂË²¨ºóÍ¼Ïñ');
imwrite(img_g,'g.tif');

% 7. clip
g = zeros(M,N);
g(1:M,1:N) = gp(1:M,1:N);
img_h = uint8(g);
subplot(2,4,8);
imshow(img_h);
title('×îÖÕ½á¹û');
imwrite(img_h,'h.tif');

function img = normalize(img_in,res_min, res_max)
in_max = max(max(img_in));
in_min = min(min(img_in));
img = round((res_max-res_min)*(img_in-in_min)/(in_max-in_min) + res_min);
end

function spectrum = getSpectrum(F)
realPart = real(F);
imagPart = imag(F);
[p,q] = size(F);
spectrum = zeros(p,q);
for i = 1:p
    for j = 1:q
        spectrum(i,j) = log((realPart(i,j)^2+imagPart(i,j)^2)^0.5 + 1);
    end
end
end


% function F = myFFT1(f)
% M = size(f);
% F = zeros(M);
% if(M == 1)
%     F = f;
% end
% K = M/2;
% f_odd = f(1:2:M-1);
% f_even = f(2:2:M);
% F_odd = myFFT1(f_odd);
% F_even = myFFT1(f_even);
% for u = 1:K
%     W = exp(-1i*2*pi*(u-1)/M);
%     F(u) = F_even(u) + F_odd(u)*W;
%     F(u+K) = F_even(u) - F_odd(u)*W;
% end
% end
% 
% function f = myIFFT1(F)
% M = size(F);
% f = zeros(M);
% if(M == 1)
%     f = F;
% end
% K = M/2;
% F_odd = F(1:2:M-1);
% F_even = F(2:2:M);
% f_odd = myIFFT1(F_odd);
% f_even = myIFFT1(F_even);
% for u = 1:K
%     W = exp(1i*2*pi*(u-1)/M);
%     f(u) = f_even(u) + f_odd(u)*W;
%     f(u+K) = f_even(u) - f_odd(u)*W;
% end
% f = f./M;
% end
% 
% function F = myFFT2(f)
% [M, N] = size(f);
% F = zeros(M,N);
% for k = 1:M
%     F(k,:) = myFFT1(f(k,:));
% end
% for k = 1:N
%     F(:,k) = myFFT1(F(:,K));
% end
% end
% 
% function f = myIFFT2(F)
% [M, N] = size(F);
% f = zeros(M,N);
% for k = 1:M
%     f(k,:) = myFFT1(F(k,:));
% end
% for k = 1:N
%     f(:,k) = myFFT1(f(:,K));
% end
% end