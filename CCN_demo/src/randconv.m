function [ans] = randconv(CS0)
    %kernel = randn(3,3)/10;
    load randomcon.mat
    kernel = randomcon;
    k_rate = (14)^2/CS0;
    fin(1,1) = 1;
    for res = 1:(CS0-1)
        fin(res+1,1) = 1+round(k_rate*res); 
    end
    ans = mat_trans(kernel,16);
    ans = ans(fin,:);
end