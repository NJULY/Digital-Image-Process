function [gradients, angle, dx, dy] = Gradients(img_in)
[w,h] = size(img_in);
gradients = zeros(w,h);
angle = zeros(w,h);
dx = zeros(w,h);
dy = zeros(w,h);
for i = 1:w-1
   for j = 1:h-1
       dx(i,j) = img_in(i+1,j)-img_in(i,j);
       dy(i,j) = img_in(i,j+1)-img_in(i,j);
       gradients(i,j) = sqrt(dx(i,j)^2+dy(i,j)^2);
       angle(i,j) = atan2(dy(i,j),dx(i,j));
   end
end
end