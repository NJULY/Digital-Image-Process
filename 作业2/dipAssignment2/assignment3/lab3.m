% 1.read image, calculate P Q
f = imread('455.png');
f = rgb2gray(f);
[M, N] = size(f);
P = 2*M; Q = 2*N;

H1 = filter(P,Q,30,2);
img1 = process(P,Q,f,H1);
H2 = filter(P,Q,60,2);
img2 = process(P,Q,f,H2);
H3 = filter(P,Q,90,2);
img3 = process(P,Q,f,H3);
H4 = filter(P,Q,120,2);
img4 = process(P,Q,f,H4);

subplot(1,4,1);
imshow(img1,[]);
title('D0=30');
imwrite(img1,'D0=30.png');
subplot(1,4,2);
imshow(img2,[]);
title('D0=60');
imwrite(img2,'D0=60.png');
subplot(1,4,3);
imshow(img3,[]);
title('D0=90');
imwrite(img3,'D0=90.png');
subplot(1,4,4);
imshow(img4,[]);
title('D0=120');
imwrite(img4,'D0=120.png');

function img_res = process(P,Q,f,H)
% 2.get the image after filling
% fp is a double matrix, or there will be no minus after translation
M=P/2; N = Q/2;
fp = zeros(P,Q);
fp(1:M,1:N) = f(1:M,1:N);

% 3. translate fp
% fpt means fp translation
fpt = zeros(P,Q);
for i = 1:M
    for j = 1:N
        fpt(i,j) = fp(i,j)*((-1)^(i+j));
    end
end

% 4. DFT, get F
F = fft2(fpt, P, Q);

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
%img_res = uint8(normalize(g,0,255));
img_res = uint8(g);
end

function img = normalize(img_in,res_min, res_max)
in_max = max(max(img_in));
in_min = min(min(img_in));
img = round((res_max-res_min)*(img_in-in_min)/(in_max-in_min) + res_min);
end

function H = filter(P,Q,D0,n)
H = zeros(P,Q);
for i = 1:P
   for j = 1:Q
       D = ((i-P/2)^2+(j-Q/2)^2)^0.5;
       H(i,j) = 1/(1+(D0/D)^(2*n));
   end
end
end


