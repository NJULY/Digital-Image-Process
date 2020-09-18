function img_out = GaussianFilter(img_in, sigma)
% 1.construct a Gaussian template
n = ceil(2*sigma+1);
if mod(n,2) == 0
    n = n+1;
end
center = (n+1)/2;
gaussianFilter = zeros(n,n);
denominator1 = 2*pi*sigma*sigma;
denominator2 = 2*sigma*sigma;
weightSum = 0;
for i = 1:n
    for j = 1:n
        numerator = (i-center)^2+(j-center)^2;
        gaussianFilter(i,j)=exp((-1)*numerator/denominator2)/denominator1;
        weightSum = weightSum + gaussianFilter(i,j);
    end
end
% 2.convolution
gaussianFilter = gaussianFilter / weightSum;
[w,h] = size(img_in);
img_expand = zeros(w+n-1, h+n-1);
img_expand(center:center+w-1, center:center+h-1)=img_in(1:w,1:h);
img_out = zeros(w,h);
for i = 1:w
   for j = 1:h
       img_out(i,j) = sum(sum(img_expand(i:i+n-1,j:j+n-1).*gaussianFilter(1:n,1:n)));
   end
end
end