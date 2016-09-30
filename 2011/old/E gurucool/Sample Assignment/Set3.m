%Reading an image i.e. Outline of your hand, im i the image matrix,
%hand.jpg is the filename of the image, factor is the percentage by which
%you want to reduce image size, im_scaled is the scaled image matrix, n is
%the no of points to be digitized, x and y are the x and y co-ordinates of the digitized points, ni is the no of points at which x and y
%needs to be interpolated. tt is the set of points at which interpolation
%needs to be done ,xx and yy are the final interpolated values of x and y 
clear all;
close all;
im=imread('hand.jpg');         %Filename of the image is hand.jpg
factor=input('Enter the percentage by which you want to reduce image size:');
scale=1-factor/100;
im_scaled=imresize(im,scale);           %Resizes the image
n=input('Enter the no of points to be digitized, n:');
imshow(im_scaled);
[x,y]=ginput(n)                    %select digitized points
save('var','x','y');
t=1:n;
ni=input('Enter the no of points at which x and y needs to be interpolated:');
tt=linspace(1,n,ni);


xx=interp1(t,x,tt,'spline');            %Interpolates the x points to xx variable
figure
subplot(2,1,1);
plot(t,x,'or',tt,xx);
title('Spline Interpolation for x co-ordinates of digitized points');
grid

yy=interp1(t,y,tt,'spline');
subplot(2,1,2);
plot(t,y,'or',tt,yy);                      %Interpolates the y points to yy variable
title('Spline Interpolation for y co-ordinates of digitized points');
grid

disp(['Figure 1 shows the outline of your hand and ']);
disp(['Figure 2 shows the data points and the connecting curve obtained using the spline interpolation ']);