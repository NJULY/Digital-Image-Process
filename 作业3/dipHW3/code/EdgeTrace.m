function newEdge = EdgeTrace(edge)
map = [0,0,0; 50,0,0; 0,50,0; 0,0,50; 50,50,0; 50,0,50; 0,50,50; 50,50,50];
[w,h] = size(edge);
newEdge = zeros(w,h);
queue = zeros(w*h,2);
color = zeros(w,h);
cnt = 0; num = 7;
for i = 2 : w-1
   for j = 2 : h-1
       if edge(i,j) == 1 && color(i,j) == 0
          queue(1,1)=i; queue(1,2)=j;
          color(i,j) = 1;
          p = 1; q = 2;
          while p < q
              % queue pop
              x = queue(p,1);
              y = queue(p,2);
              p = p+1;
              color(x,y) = 2;
              newEdge(x,y)=cnt+1;
              % check 8-neighbor
              c=[x-1,y-1;x-1,y;x-1,y+1; x,y-1;x,y+1; x+1,y-1;x+1,y;x+1,y+1];
              for z = 1:8
                  c1 = c(z,1); c2 = c(z,2);
                  if edge(c1,c2)==1 && color(c1,c2)==0
                      % queue push
                     queue(q,1)=c1; queue(q,2)=c2;
                     q=q+1; color(c1,c2)=1;
                  end
              end
          end
          cnt = mod(cnt+1, num);
       end
   end
end
newEdge = ind2rgb(uint8(newEdge), map);
end