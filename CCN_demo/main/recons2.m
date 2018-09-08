function [reimg,sim] = recons2(Image,compress,CR)
    recons = [];
    %ad = SparseRandomMtx(86,256,10);
    CR_line = ceil(512*CR);
    imge = Image;
    for channel = 1:3
    [ch,ku] = size(imge(:,:,channel));
    temp = zeros(512,512) + 2;
    temp(1:ch,1:ku) = imge(:,:,channel); 
    temp=double(temp); 
    %Phi=compress;
            if compress == 1
                Phi = randn(CR_line,512);
            elseif compress == 2
                Phi = adagio(temp,CR_line);
            elseif compress == 3
                Phi = SparseRandomMtx(CR_line,512,10);
            end
            img = temp;

            [n,b]=size(img);             
            weizhi=1;         
            for i=1:n                          
                Phi(:,i) = Phi(:,i) / norm(Phi(:,i));
            end 
            y=Phi*img;       

 
            Psi=DWT(n);                         %  
            A = Phi*Psi';                       %  
            y = y*Psi';                         % 

            ReS3 = zeros(n,b);
            for i = 1:b                        
                rec = omp(y(:,i),A,n);           %
                ReS3(:,i) = rec;
            end
            ReS3 = Psi'*sparse(ReS3)*Psi;       %%%%%%%%%%%%%%%         
            ReImg3 = full(ReS3);
            recons(:,:,channel) = ReImg3;
    end
    reimg = recons(1:ch,1:ku,:);
    reimg = uint8(reimg);
    sim(1,1) = psnr(reimg,Image);
    sim(2,1) = ssim(reimg,Image);
end
