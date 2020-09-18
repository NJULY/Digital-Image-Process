function res_edge = ConnectivityAnalyse(edge,theta)
TL = theta*max(max(edge));
TH = 2.5*TL;
[w,h] = size(edge);
res_edge = zeros(w,h);
tmp_edge = zeros(w+2,h+2);
tmp_edge(2:w+1, 2:h+1) = edge(1:w,1:h);
for i = 2:w+1
   for j = 2:h+1
       if tmp_edge(i,j)<=TL
           res_edge(i-1,j-1)=0;
       elseif tmp_edge(i,j)>=TH
           res_edge(i-1,j-1)=1;
       else
           if tmp_edge(i-1,j-1)>=TH||tmp_edge(i-1,j)>=TH||tmp_edge(i-1,j+1)>=TH||tmp_edge(i,j-1)>=TH||tmp_edge(i,j+1)>=TH||tmp_edge(i+1,j-1)>=TH||tmp_edge(i+1,j)>=TH||tmp_edge(i+1,j+1)>=TH
               res_edge(i-1,j-1)=1;
           end
       end
   end
end
res_edge(1:2,:)=zeros(2,h);
res_edge(w-1:w,:)=zeros(2,h);
res_edge(:,1:2)=zeros(w,2);
res_edge(:,h-1:h)=zeros(w,2);
for i = 2:w-1
   for j = 2:h-1
%       if eq(res_edge(i,j), 1) & eq(sum(res_edge(i-1:i+1,j-1:j+1)), 1)
%           res_edge(i,j) = 0;
%       end
        if res_edge(i-1,j-1)==0 && res_edge(i-1,j)==0 && res_edge(i-1,j+1)==0 && res_edge(i,j-1)==0 && res_edge(i,j)==1 && res_edge(i,j+1)==0 && res_edge(i+1,j-1)==0 && res_edge(i+1,j)==0 && res_edge(i+1,j+1)==0
            res_edge(i,j) = 0;
        end
   end
end
res_edge = uint8(res_edge);
end