function[circlefind]=findcircle(img,minr,maxr,stepr,stepa,percent)
r=round((maxr-minr)/stepr)+1;% number of steps that can be increased
angle=round(2*pi/stepa);
[m,n]=size(img);
 houghspace=zeros(m,n,r);% Hough space
 [m1,n1]=find(img);% returns the coordinates of the non-zero point in the binary edge detection image Img, m1 stores the abscissa, n1 stores the ordinate
 num=size(m1,1);% number of non-zero points
 % Hough space, counting the number of identical dots
%a = x-r*cos(angle), b = y-r*sin(angle)
for i=1:num
    for j=1:r
        for k=1:angle
            a=round(m1(i)-(minr+(j-1)*stepr)*cos(k*stepa));
            b=round(n1(i)-(minr+(j-1)*stepr)*sin(k*stepa));
            if(a>0&&a<=m&&b>0&&b<=n)
                houghspace(a,b,j)=houghspace(a,b,j)+1;
            end
        end
    end
end
 % Uses threshold to detect circles
 par=max(max(max(houghspace)));% Find the number of circles with the largest number as the threshold
 par2=par*percent;% percentage threshold adjustment
[m2,n2,r2]=size(houghspace);
 circlefind=[];% stores the center coordinates and radius of the circle greater than the threshold
for i=1:m2
    for j=1:n2
        for k=1:r2
            if (houghspace(i,j,k)>=par2)
                a=[i,j,minr+k*stepr];
                circlefind=[circlefind;a];
            end
        end
    end
end
end