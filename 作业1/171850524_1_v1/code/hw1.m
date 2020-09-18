process("1a","1b","res1-1");
process("2a","2b","res2-2");
process("1a","2b","res1-2");
process("2a","1b","res2-1");

function process(file1,file2,file3)
% read pictures
img_a = imread('../asset/'+file1+'.jpg'); % original image
img_b = imread('../asset/'+file2+'.jpg'); % template image
% process R G B respectively
% get the data of R G B
r1 = img_a(:,:,1);
g1 = img_a(:,:,2);
b1 = img_a(:,:,3);
r2 = img_b(:,:,1);
g2 = img_b(:,:,2);
b2 = img_b(:,:,3);
% equalization
r1_s = histogram_equalization(r1);
g1_s = histogram_equalization(g1);
b1_s = histogram_equalization(b1);
r2_s = histogram_equalization(r2);
g2_s = histogram_equalization(g2);
b2_s = histogram_equalization(b2);
% match original and template
r_trans = r2z(r1_s, r2_s);
g_trans = r2z(g1_s, g2_s);
b_trans = r2z(b1_s, b2_s);
% get the image after processing
[height, width] = size(r1);
img_trans = zeros(height, width, 3);
for i = 1 : height
    for j = 1 : width
        img_trans(i,j,1) = r_trans(uint8(r1(i, j))+1);
        img_trans(i,j,2) = g_trans(uint8(g1(i, j))+1);
        img_trans(i,j,3) = b_trans(uint8(b1(i, j))+1);
    end
end
imwrite(uint8(img_trans), '../asset/'+file3+'.jpg');
end


function s_table = histogram_equalization(gray_values)
[height, width] = size(gray_values);
L = 256;
r_table = zeros(1, L);
for i = 1 : height
    for j = 1 : width
        value = gray_values(i, j) + 1;
        r_table(1, value) = r_table(1, value) + 1;
    end
end
s_table = zeros(1, L);
s_table(1,1) = r_table(1,1);
for i = 2 : L
    s_table(1, i) = s_table(1, i-1) + r_table(1, i);
end
parameter = (L-1) / (height * width);
for i = 1 : L
    s_table(1, i) = s_table(1, i) * parameter;
    % round() will lead to big error, which is obvious in the image
end
end

% function r2z makes a transition from image_a to image_b
function trans = r2z(table1, table2)
trans = zeros(1, 256);
for i = 1 : 256
    value = table1(1,i);
    delta = 256;
    index = 1;
    for j = 1 : 256
        if abs(table2(1, j) - value) < delta
            delta = abs(table2(1, j) - value);
            index = j;
        end
    end
    trans(1, i) = index - 1;
end
end