function d = myLocalDescriptor(I,p,rhom,rhoM,rhostep ,N)

[rows,cols,z] = size(I);
rho = rhom:rhostep:rhoM;

if z == 3
    d = zeros(length(rho),N,3);
else
    d = zeros(length(rho),N,1);
end

for i = 1:length(rho)
    for j = 1:N
        theta = j*2*pi/N;
        x = floor(p(1) - rho(i)*sin(theta));
        y = floor(p(2) + rho(i)*cos(theta));
        if (x>=1 && y>=1 && x<=size(I,1) &&  y<=size(I,2)) 
             val = 0;
             neighbors = 0;
             if x > 1
                 val = val + double(I(x-1,y,:));
                 neighbors = neighbors+1;
             end

             if x < rows
                val = val + double(I(x+1,y,:));
                neighbors = neighbors+1;
             end

             if y > 1 
                 val = val + double(I(x,y-1,:));
                 neighbors = neighbors+1;
             end

             if y < cols 
                 val = val + double(I(x,y+1,:));
                 neighbors = neighbors+1;
             end
             d(i,j,:) = floor(val/neighbors);


        end    

    end
end

