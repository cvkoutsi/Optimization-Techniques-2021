function rotImg = myImgRotation(img, angle)

[M,N,z] = size(img);
mid = [round(M/2),round(N/2)];

theta = angle*pi/180;

%find dimensions of rotated image so that the whole rotated image fits 
M_rot = round(M*abs(cos(theta)) + N*abs(sin(theta)));
N_rot = round(M*abs(sin(theta)) + N*abs(cos(theta)));
mid_rot = [round(M_rot/2),round(N_rot/2)];

%set black background
rotImg=uint8(zeros(M_rot,N_rot,z)); 

%double for that scans the rotated image
for i=1:size(rotImg,1)
    for j=1:size(rotImg,2)                                                       
        
         %find the point of initial image that corresponds to the each point
         %of the rotated image
         x= (i-mid_rot(1))*cos(theta)+(j-mid_rot(2))*sin(theta);
         y= -(i-mid_rot(1))*sin(theta)+(j-mid_rot(2))*cos(theta);                            
         x=floor(x)+mid(1);
         y=floor(y)+mid(2);

         if (x>=1 && y>=1 && x<=size(img,1) &&  y<=size(img,2)) 
             val = 0;
             neighbors = 0;
             if x > 1
                 val = val + double(img(x-1,y,:));
                 neighbors = neighbors+1;
             end
             
             if x < M
                val = val + double(img(x+1,y,:));
                neighbors = neighbors+1;
             end
             
             if y > 1 
                 val = val + double(img(x,y-1,:));
                 neighbors = neighbors+1;
             end
             
             if y < N 
                 val = val + double(img(x,y+1,:));
                 neighbors = neighbors+1;
             end
             rotImg(i,j,:) = uint8(floor(val/neighbors));
         end
    end
end

end

