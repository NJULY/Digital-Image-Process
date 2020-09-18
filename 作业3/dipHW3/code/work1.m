img_in1 = rgb2gray(imread('../asset/disk.jpg'));
img_in2 = rgb2gray(imread('../asset/rubberband_cap.png'));
img_in3 = rgb2gray(imread('../asset/leaf.jpg'));
img_in4 = rgb2gray(imread('../asset/castle.jpg'));
img_in5 = rgb2gray(imread('../asset/giraffe.jpg'));
img_in6 = rgb2gray(imread('../asset/plane.jpg'));

edge1 = process(img_in1);
imwrite(edge1,'../asset/disk_edge.jpg');
edge2 = process(img_in2);
imwrite(edge2,'../asset/rubberband_cap_edge.png');
edge3 = process(img_in3);
imwrite(edge3,'../asset/leaf_edge.jpg');
edge4 = process(img_in4);
imwrite(edge4,'../asset/castle_edge.jpg');
edge5 = process(img_in5);
imwrite(edge5,'../asset/giraffe_edge.jpg');
edge6 = process(img_in6);
imwrite(edge6,'../asset/plane_edge.jpg');

subplot(3,2,1);
imshow(edge1);
subplot(3,2,2);
imshow(edge2)
subplot(3,2,3);
imshow(edge3);
subplot(3,2,4);
imshow(edge4);
subplot(3,2,5);
imshow(edge5);
subplot(3,2,6);
imshow(edge6);
 
function newEdge = process(img_in)
img_out = GaussianFilter(img_in, 2);
img_out = GaussianFilter(img_out, 2);
[gradients, angle, dx, dy] = Gradients(img_out); 
newGradients = NMS(gradients, angle, dx, dy);
edge = ConnectivityAnalyse(newGradients,0.05);
newEdge = EdgeTrace(edge);
end
