function [Phi] = BernoulliMtx(M,N)
    Phi = randi([0,1],M,N);
    Phi(Phi == 0) = -1;
end