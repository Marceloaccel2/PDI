im = imread('pic.jpg');
len = size(im);

%Additive brightness values
aR = input(aRED);
aG = input(aGREEN);
aB = input(aBLUE);
aY = input(ayBRIGHT);

%Multiplicative brightness values
mR = input(mRED);
mG = input(mGREEN);
mB = input(mBLUE);
mY = input(myBRIGHT);

%Threshold value
limiar = input(val);

%Middle filter order
meanOrder = input(meanO);

%Conversion RGB - YIQ
YIQ = uint8(zeros(len));
for i = 1:size(im,1)
    for j = 1:size(im,2)
        YIQ(i,j,1) = 0.299*im(i,j,1) + 0.587*im(i,j,2) + 0.114*im(i,j,3);
        YIQ(i,j,2) = 0.596*im(i,j,1) - 0.274*im(i,j,2) - 0.322*im(i,j,3);
        YIQ(i,j,3) = 0.211*im(i,j,1) - 0.523*im(i,j,2) + 0.312*im(i,j,3);
    end
end
imwrite(YIQ,'rgb-yiq.png');

%Conversion YIQ - RGB
RGB = uint8(zeros(size(YIQ)));
for i = 1:size(YIQ,1)
    for j = 1:size(YIQ,2)
          RGB(i,j,1) = YIQ(i,j,1) + 0.956*YIQ(i,j,2) + 0.621*YIQ(i,j,3);
          RGB(i,j,2) = YIQ(i,j,1) - 0.272*YIQ(i,j,2) - 0.647*YIQ(i,j,3);
          RGB(i,j,3) = YIQ(i,j,1) - 1.106*YIQ(i,j,2) + 1.703*YIQ(i,j,3);
    end
end
imwrite(RGB,'yiq-rgb.png');

%Channels R,G e B
imR = im;
imG = im;
imB = im;
x = len(1,1);
imR(1:x,:,1) = 255;
imG(1:x,:,2) = 255;
imB(1:x,:,3) = 255;
imwrite(imR,'cRed.png');
imwrite(imG,'cGreen.png');
imwrite(imB,'cBlue.png');


%Negative RGB
negRGB = uint8(-1*(double(im)-255));
imwrite(negRGB,'negRGB.png');

%Negative YIQ
negYIQ = uint8(-1*(double(YIQ)-255));
imwrite(negYIQ,'negYIQ.png');

%Bright Add RGB
aRED = 'Digite o valor aditivo para o brilho na banda R: ';
aGREEN = 'Digite o valor aditivo para o brilho na banda G: ';
aBLUE = 'Digite o valor aditivo para o brilho na banda B: ';
bright_add_rgb = uint8(zeros(len));
for i = 1:size(im,1)
    for j = 1:size(im,2)
        bright_add_rgb(i,j,1) = aR + im(i,j,1);
        bright_add_rgb(i,j,2) = aG + im(i,j,2);
        bright_add_rgb(i,j,3) = aB + im(i,j,3);
    end
end
imwrite(bright_add_rgb,'bright_add_RGB.png');

%Bright Mult RGB

mRED = 'Digite um valor positivo de brilho multiplicativo da banda R: ';
mGREEN = 'Digite um valor positivo de brilho multiplicativo da banda G: ';
mBLUE = 'Digite o valor positivo de brilho multiplicativo B: ';
bright_mult_rgb = uint8(zeros(len));
for i = 1:size(im,1)
    for j = 1:size(im,2)
        bright_mult_rgb(i,j,1) = mR*im(i,j,1);
        bright_mult_rgb(i,j,2) = mG*im(i,j,2);
        bright_mult_rgb(i,j,3) = mB*im(i,j,3);
    end
end
imwrite(bright_mult_rgb,'bright_mult_RGB.png');

%Bright Add Y
ayBRIGHT = 'Digite o valor aditivo para o brilho em Y: ';
bright_add_y = 0.2989*im(:,:,1) + 0.587*im(:,:,2) + 0.114*im(:,:,3);
bright_add_y = bright_add_y + aY;
imwrite(bright_add_y,'bright_add_Y.png');

%Bright Mult Y
myBRIGHT = 'Digite o valor multiplicativo para o brilho em Y: ';
bright_mult_y = 0.2989*im(:,:,1) + 0.587*im(:,:,2) + 0.114*im(:,:,3);
bright_mult_y = bright_mult_y * mY;
imwrite(bright_mult_y,'bright_mult_Y.png');

%Contrast level
%im = imread('ibagem.jpg');
%limiar = 100;
%a = double(im)/limiar;
%b = a.^2;
%c = uint8(b*limiar);


%Threshold user
val = 'Digite o valor do limiar para a binarizacao: ';
GSim = 0.2989*im(:,:,1) + 0.5870*im(:,:,2) + 0.1140*im(:,:,3);
GSim(GSim <= limiar) = 0;
GSim(GSim > limiar) = 255;
imwrite(GSim,'threshold_user.png');


%Threshold Y
threshold = 0.2989*im(:,:,1) + 0.587*im(:,:,2) + 0.114*im(:,:,3);
mean1 = mean(threshold);
mean2 = mean(mean1);
threshold(threshold <= mean2) = 0;
threshold(threshold > mean2) = 255;
imwrite(threshold,'threshold_mean.png');

%Mean Filter
mean_filter = im;
meanO = 'Digite a ordem do filtro de media: ';
matriz = ones(meanO,meanO)/ (meanO * meanO);
F = conv2(mean_filter,matriz);
imwrite(F,'filtro de media.png');











