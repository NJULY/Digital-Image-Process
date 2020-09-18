f = imread('woman.png');
%img = GaussianFilter(f);
img = bilateralFilter(double(f),[],0,1.0,2,0.3);
subplot(1,2,1);
imshow(f,[]);
subplot(1,2,2);
imshow(img,[]);
imwrite(uint8(normalize(img,0,255)),'out.png');

%Gaussian filter
function img = GaussianFilter(f)
% 1.read image, calculate P Q
[M, N] = size(f);
subplot(1,2,1);
imshow(f);
P = 2*M; Q = 2*N;
% 2.get the image after filling
fp = zeros(P,Q);
fp(1:M,1:N) = f(1:M,1:N);
% 3. translate fp
fpt = zeros(P,Q);
for i = 1:M
    for j = 1:N
        fpt(i,j) = fp(i,j)*((-1)^(i+j));
    end
end
% 4. DFT, get F
F = fft2(fpt, P, Q);
% 5. make filter H
H = zeros(P,Q);
% D0 needs to be set manually
D0 = 8; 
for i = 1:P
   for j = 1:Q
       H(i,j) = exp(-((i-M)^2+(j-N)^2)^0.5 / (2*D0^2));
   end
end
% 6.
G = H.*F;
% gbt means fp after translation
gbt = real(ifft2(G));
gp = zeros(P,Q);
for i = 1:M
    for j = 1:N
        gp(i,j) = gbt(i,j)*(-1)^(i+j);
    end
end
% 7. clip
g = zeros(M,N);
g(1:M,1:N) = gp(1:M,1:N);
img = g;
end

function img = normalize(img_in,res_min, res_max)
in_max = max(max(img_in));
in_min = min(min(img_in));
img = round((res_max-res_min)*(img_in-in_min)/(in_max-in_min) + res_min);
end