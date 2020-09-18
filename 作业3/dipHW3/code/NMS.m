function newGradients = NMS(g, angle,dx, dy)
[w,h] = size(g);
newGradients = g;
for i = 2:w-1
   for j = 2:h-1
       a = 0;
       b = 0;
       if g(i,j) ~= 0
           if dx(i,j) == 0
               a = g(i,j+1);
               b = g(i,j-1);
           elseif dy(i,j) == 0
               a = g(i-1,j);
               b = g(i+1,j);
           else
               if abs(dx(i,j)) > abs(dy(i,j))
                   weight = abs(dy(i,j)) / abs(dx(i,j));
                   if dx(i,j)*dy(i,j) > 0
                       a = g(i+1,j)*weight+g(i+1,j+1)*(1-weight);
                       b = g(i-1,j)*weight+g(i-1,j-1)*(1-weight);
                   else
                       a = g(i+1,j)*weight+g(i+1,j-1)*(1-weight);
                       b = g(i-1,j)*weight+g(i-1,j+1)*(1-weight);
                   end
               elseif abs(dx(i,j)) < abs(dy(i,j))
                   weight = abs(dx(i,j)) / abs(dy(i,j));
                   if dx(i,j)*dy(i,j) > 0
                       a = g(i,j+1)*weight+g(i+1,j+1)*(1-weight);
                       b = g(i,j-1)*weight+g(i-1,j-1)*(1-weight);
                   else
                       a = g(i,j+1)*weight+g(i+1,j-1)*(1-weight);
                       b = g(i,j-1)*weight+g(i-1,j+1)*(1-weight);
                   end
               else
                   if dx(i,j) > 0
                       a = g(i+1,j+1);
                       b = g(i-1,j-1);
                   else
                       a = g(i+1,j-1);
                       b = g(i-1,j+1);
                   end
               end
           end
       end
       if g(i,j) >= a && g(i,j) >= b
           newGradients(i,j) = g(i,j);
       else
           newGradients(i,j) = 0;
       end
   end
end
% for i = 2:w-1
%    for j = 2:h-1
%        t = angle(i,j);
%        if (t<=pi/8&&t>=-pi/8) || t>=pi*7/8 || t<=-pi*7/8
%            if g(i,j)>=g(i-1,j) && g(i,j)>=g(i+1,j)
%                newGradients(i,j)=g(i,j);
%            else
%                newGradients(i,j)=0;
%            end
%        elseif (t>=pi/8&&t<=pi*3/8) || (t>=-pi*7/8&&t<=-pi*5/8)
%            if g(i,j)>=g(i-1,j-1) && g(i,j)>=g(i+1,j+1)
%                newGradients(i,j)=g(i,j);
%            else
%                newGradients(i,j)=0;
%            end
%        elseif (t>=pi*3/8&&t<=i*5/8)||(t>=-pi*5/8&&t<=-pi*3/8)
%            if g(i,j)>=g(i,j-1) && g(i,j)>=g(i,j+1)
%                newGradients(i,j)=g(i,j);
%            else
%                newGradients(i,j)=0;
%            end
%        else
%            if g(i,j)>=g(i-1,j+1) && g(i,j)>=g(i+1,j-1)
%                newGradients(i,j)=g(i,j);
%            else
%                newGradients(i,j)=0;
%            end
%        end
%    end
% end
end