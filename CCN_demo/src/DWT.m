function ww=DWT(N)

[h,g]= wfilters('sym8','d');       

% N=256;                           
L=length(h);                       
rank_max=log2(N);                 
rank_min=double(int8(log2(L)))+1;  
ww=1;   


for jj=rank_min:rank_max
    
    nn=2^jj;
    
   
    p1_0=sparse([h,zeros(1,nn-L)]);
    p2_0=sparse([g,zeros(1,nn-L)]);
    
   
    for ii=1:nn/2
        p1(ii,:)=circshift(p1_0',2*(ii-1))';
        p2(ii,:)=circshift(p2_0',2*(ii-1))';
    end
    

    w1=[p1;p2];
    mm=2^rank_max-length(w1);
    w=sparse([w1,zeros(length(w1),mm);zeros(mm,length(w1)),eye(mm,mm)]);
    ww=ww*w;
    
    clear p1;clear p2;
end
