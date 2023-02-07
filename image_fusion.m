im1 = dlmread('30m.txt');
im3 = dlmread('56m.txt');
j=im3;
%i = 1;
%j = 1;
%I1sample = zeros(row1,col1);
%for x = 1:2:row2
%    for y = 1:2:col2
%        I1sample(i,j) = I1(x,y);
%        j = j+1;
%    end
%i = i+1
%j = 1;
%end
%figure, imshow(I1);
%figure, imshow(I1sample/255);
im2 = imresize(j, [871 1037]);

figure(1);imshow(im2,[]);title('56m resolution');
figure(2);imshow(im1,[]);title('30m resolution');

% PCA baseb fusion
C = cov([im1(:) im2(:)]);
[V, D] = eig(C);
if D(1,1) >= D(2,2)
  pca = V(:,1)./sum(V(:,1));
else  
  pca = V(:,2)./sum(V(:,2));
end
% fusion
imf = pca(1)*im1 + pca(2)*im2;
figure(3);imshow(imf,[]);title('fused image');
%imwrite(imf,'C:\Users\PRINCE\Documents\Thesis\im3.jpg');

%DWT based fusion
%[a1,b1,c1,d1]=dwt2(im1,'db2');
%[a2,b2,c2,d2]=dwt2(im2,'db2');
%[k1,k2]=size(a1);
%% Fusion Rules
%% Average Rule
%for i=1:k1
%    for j=1:k2
%        a3(i,j)=(a1(i,j)+a2(i,j))/2;
%   end
%end
%% Max Rule
%for i=1:k1
%    for j=1:k2
%        b3(i,j)=max(b1(i,j),b2(i,j));
%        c3(i,j)=max(c1(i,j),c2(i,j));
%        d3(i,j)=max(d1(i,j),d2(i,j));
%    end
%end
%% Inverse Wavelet Transform 
%c=idwt2(a3,b3,c3,d3,'db2');
%figure,imshow(c,[])
%title('Fused Image')

fid = fopen('output.txt', 'wt');
for i = 1 : 871
  for j = 1 : 1037
    fprintf(fid, '%d ',imf(i,j));
  end
  fprintf(fid,'\n');
end
fclose(fid);

