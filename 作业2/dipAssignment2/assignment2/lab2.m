f = imread('3_3.JPG');
subplot(2,3,1);
imshow(f);
title(' ‰»ÎÕºœÒ');
sobel = [-1,0,1; -2,0,2; -1,0,1];

img = spaceFilter(f,sobel);
img = normalize(img,0,255);
subplot(2,3,4);
imshow(uint8(img));
title('ø’º‰¬À≤®');
imwrite(uint8(img),'3.JPG'); % spatial

[w1,h1] = size(f);
[w2,h2] = size(sobel);
p = w1+w2-1;
q = h1+h2-1;
fp = zeros(p, q);
hp = zeros(p, q);
fp(1:w1,1:h1) = f(1:w1,1:h1);
hp((p-w2+3)/2:(p-w2+1)/2+w2,(q-h2+3)/2:(q-h2+1)/2+h2) = sobel(1:w2,1:h2);

for i = 1:p
    for j = 1:q
        fp(i,j) = fp(i,j)*((-1)^(i+j));
    end
end
%the center of F is (p/2, q/2)
F = fft2(fp, p, q);
spectrum = getSpectrum(F);
subplot(2,3,2);
imshow(spectrum,[]);
title(' ‰»ÎÕºœÒµ√∏µ¿Ô“∂∆◊');
imwrite(uint8(normalize(spectrum,0,255)), '1.JPG');

for i = 1:p
   for j = 1:q
       hp(i,j) = hp(i,j)*((-1)^(i+j));
   end
end
% center of H is (p/2, q/2);
H = fft2(hp,p,q);
for i = 1:p
   for j = 1:q
       H(i,j) = H(i,j)*((-1)^(i+j));
   end
end
H = complex(zeros(p,q), imag(H));
subplot(2,3,3);
imshow(imag(H),[]);
title('¬À≤®∆˜');
imwrite(uint8(normalize(imag(H),0,255)),'2.JPG');

G = H.*F;
gbt = real(ifft2(G));
gp = zeros(p,q);
for i = 1:p
    for j = 1:q
        gp(i,j) = gbt(i,j)*(-1)^(i+j);
    end
end
img_g = uint8(normalize(gp,0,255));
subplot(2,3,5);
imshow(img_g);
title('∆µ¬ ”Ú¬À≤®');
imwrite(img_g,'4.JPG');


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

function img = spaceFilter(f, sobel)
[m,n] = size(f);
fp = zeros(m+2, n+2);
fp(2:1+m, 2:1+n) = f(1:m, 1:n);
img = zeros(m,n);
for i = 2:1+m
    for j = 2:1+n
        % img(i-1,j-1)=fp(i-1,j-1)*sobel(1,1)+fp(i-1,j)*sobel(1,2)+fp(i-1,j+1)*sobel(1,3)+fp(i,j-1)*sobel(2,1)+fp(i,j)*sobel(2,2)+fp(i,j+1)*sobel(2,3)+fp(i+1,j-1)*sobel(3,1)+fp(i+1,j)*sobel(3,2)+fp(i+1,j+1)*sobel(3,3);
        img(i-1,j-1)=fp(i-1,j-1)*sobel(3,3)+fp(i-1,j)*sobel(3,2)+fp(i-1,j+1)*sobel(3,1)+fp(i,j-1)*sobel(2,3)+fp(i,j)*sobel(2,2)+fp(i,j+1)*sobel(2,1)+fp(i+1,j-1)*sobel(1,3)+fp(i+1,j)*sobel(1,2)+fp(i+1,j+1)*sobel(1,1);
    end
end
end