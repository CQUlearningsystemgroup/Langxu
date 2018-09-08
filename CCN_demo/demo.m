clear all
close all

addpath('src','Image','main');

Image = imread('002760.jpg');

%%%%%%%%%%%%%  set
CR = 0.33   ;                     %compression rate
[I_line,I_row] = size(Image(:,:,1));
CR_line = ceil(256 * CR);

%%%%%%%%%%%%%  build compress matrix
CCN = ccn(CR_line);
[CCN_recons,sim1] = recons3(CCN,Image);

RandConv = randconv(CR_line);
[RandConv_recons,sim2] = recons3(RandConv,Image);

%Gauss = randn(85,256);
[Gauss_recons,sim3] = recons2(Image,1,CR); 

%ADAGIO = adagio(Image,CR_line); 
[ADAGIO_recons,sim4] = recons2(Image,2,CR);

%CS_SM = SparseRandomMtx(CR_line,I_row,10);
[CS_SM_recons,sim5] = recons2(Image,3,CR);

%%%%%%%%%% draw results
load pos.mat     %result of yolo
subplot(2,3,1);
imshow(Image),title('Input Image');

subplot(2,3,2);
a1 = num2str(sim1(1,1));
a2 = num2str(sim1(2,1));
a3 = strcat('CCN',' PSNR=',a1,' SSIM=',a2);
imshow(CCN_recons,'border','tight'),title(a3);
        rectangle( 'Position', pos, 'EdgeColor', 'r');  
        text(29,11, 'cat','FontSize',10,'Color','k','backgroundcolor','r');
        rectangle( 'Position', pos1, 'EdgeColor', 'r');  
        text(260,53, 'cat','FontSize',10,'Color','k','backgroundcolor','r');
        
subplot(2,3,3);
a1 = num2str(sim3(1,1));
a2 = num2str(sim3(2,1));
a3 = strcat('Gauss',' PSNR=',a1,' SSIM=',a2);
imshow(Gauss_recons),title(a3);
        rectangle( 'Position', pos, 'EdgeColor', 'r');  
        text(29,11, 'cat','FontSize',10,'Color','k','backgroundcolor','r');
        rectangle( 'Position', pos1, 'EdgeColor', 'r');  
        text(260,53, 'cat','FontSize',10,'Color','k','backgroundcolor','r');
        
subplot(2,3,4);
a1 = num2str(sim4(1,1));
a2 = num2str(sim4(2,1));
a3 = strcat('ADAGIO',' PSNR=',a1,' SSIM=',a2);
imshow(ADAGIO_recons),title(a3);
        rectangle( 'Position', pos, 'EdgeColor', 'r');  
        text(29,11, 'cat','FontSize',10,'Color','k','backgroundcolor','r');
        rectangle( 'Position', pos1, 'EdgeColor', 'r');  
        text(260,53, 'cat','FontSize',10,'Color','k','backgroundcolor','r');
        
subplot(2,3,5);
a1 = num2str(sim2(1,1));
a2 = num2str(sim2(2,1));
a3 = strcat('RandConv',' PSNR=',a1,' SSIM=',a2);
imshow(RandConv_recons),title(a3);
        rectangle( 'Position', pos, 'EdgeColor', 'r');  
        text(29,11, 'cat','FontSize',10,'Color','k','backgroundcolor','r');
        rectangle( 'Position', pos1, 'EdgeColor', 'r');  
        text(260,53, 'cat','FontSize',10,'Color','k','backgroundcolor','r');
        
subplot(2,3,6);
a1 = num2str(sim5(1,1));
a2 = num2str(sim5(2,1));
a3 = strcat('CS-SM',' PSNR=',a1,' SSIM=',a2);
imshow(CS_SM_recons),title(a3);
        rectangle( 'Position', pos, 'EdgeColor', 'r');  
        text(29,11, 'cat','FontSize',10,'Color','k','backgroundcolor','r');
        rectangle( 'Position', pos1, 'EdgeColor', 'r');  
        text(260,53, 'cat','FontSize',10,'Color','k','backgroundcolor','r');
