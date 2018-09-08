function hat_y=omp(s,T,N)


Size=size(T);                                    
M=Size(1);                                        
hat_y=zeros(1,N);                                              
Aug_t=[];                                        
r_n=s;                                            

for times=1:M;                                    

    for col=1:N;                                  
    end
    [val,pos]=max(product);                      
    Aug_t=[Aug_t,T(:,pos)];                       
    T(:,pos)=zeros(M,1);                          
    aug_y=(Aug_t'*Aug_t)^(-1)*Aug_t'*s;          
    r_n=s-Aug_t*aug_y;                            
    pos_array(times)=pos;                        

    if (abs(aug_y(end))^2/norm(aug_y)<0.0003)     
        break;
    end
end

hat_y(pos_array)=aug_y;                           
end


