function[trans] = adagio(img,r)
img = img(:,:,1);
[n,T] = size(img);
Theta = 0.5;
k = (1/Theta)^2*log(T);
k = ceil(k);
img = double(img);
[COEFE,SCORE,latent]=pca(img);
size1 = r-k;
S1 = rand(k,T);
f = 1/sqrt(k);
S2 = -1*f+2*f.*S1;
P = COEFE(:,1:size1);
P = P';

trans0=[P;S2-S2*(P'*P)];
trans =trans0;
end