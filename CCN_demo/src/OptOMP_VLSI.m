
function [ x, active_set,t] =OptOMP_VLSI(A, y, varargin )

STOPPING_GROUND_TRUTH = -1;
STOPPING_DUALITY_GAP = 1;
STOPPING_SPARSE_SUPPORT = 2;
STOPPING_OBJECTIVE_VALUE = 3;
STOPPING_SUBGRADIENT = 4;


stopping_criterion = STOPPING_OBJECTIVE_VALUE;
verbose = 0;
tolerance = 0.5;
lambda = 0;
[m,n]= size(A);
max_iters=800;

% Parameters for linsolve function
% Global variables for linsolve function

opts_lower.LT = true; opts_lower.TRANSA = false;  %求解A*X=B中的X，
opts_upper.LT = true; opts_upper.TRANSA = true;   %求解A'*X=B中的X.


% Parse the optional inputs.
if (mod(length(varargin), 2) ~= 1 )
    error(['Extra Parameters passed to 888the function ''' mfilename ''' must be passed in pairs.']);
end
parameterCount = length(varargin)/2;

for parameterIndex = 1:parameterCount,
    parameterName = varargin{parameterIndex*2 - 1};
    parameterValue = varargin{parameterIndex*2};
    switch lower(parameterName)
        case 'lambda'
            lambda = parameterValue;
        case 'max_iters'
            if parameterValue>max_iters
                if DEBUG>0
                    warning('Parameter maxIteration is larger than the possible value: Ignored.');
                end
            else
                max_iters = parameterValue;
            end
        case 'tolerance'
            tolerance = parameterValue;
        case 'verbose'
            verbose = parameterValue;
        otherwise
            error(['The parameter ''' parameterName ''' is not recognized by the function ''' mfilename '''.']);
    end
end

% Initialize
r = y;
x = zeros(n,1);
% d = zeros(n,1);
active_set = [];
t = 1;

L = [];
D = [];

done = 0; 
% d_history = [];
% x_history = [];
% r_history = [];
% Iterative Optimization
% run_time = toc;

while ~done && t<=max_iters
%     tic;
    corr = A'*r;            %如果A矩阵是一个m*n的矩阵，那么y=m,corr为n*1
%     [maxcorr I] = max(abs(corr./sqrt(sum(A.^2))'));
    [maxcorr, I] = max(abs(corr));
     
%     run_time = run_time + toc;   
     
    if maxcorr==0
        warning('No atom in the dictionary is correlated to the residue any more. Iteration terminated.');
        done=1;        
    else
        new_index = I(1); 
        active_set = [active_set new_index];   %更新活跃集合
        h = A(:,active_set)'*A(:,new_index);    %A矩阵M*N中的对应活跃列假如有3个就是m*3转置3*m乘以m*1，h就是3*1
        
        if verbose
            disp(['Iteration # ' num2str(t) ': add atom ' num2str(new_index) ' to the active set.'])
        end
         % Update A_I'*A_I Matrix and Cholesky factorization of A_I'*A_I
         % with only the new atom involved
        if t==1
            D = A(:,new_index)'*A(:,new_index);   %第一值，
            L = 1;                  %L为1；
        else
            w = linsolve(L,h(1:end-1),opts_lower);     %矩阵中的第22位置的值=(t-1)*1
            l21 = w./diag(D);
            d22 = h(end)-l21'*w;
            
            
            L = [L     zeros(size(L,1),1)
                 l21'  1                ];
            D = [D                  zeros(size(D,1),1)
                 zeros(1,size(D,1)) d22               ];
        end
        
%         corr_active_set = corr(active_set);
%         z = linsolve(L,corr_active_set,opts_lower);
        z = [zeros(size(L,1)-1,1); corr(new_index)];%Z为新构成的m*1的向量，corr为n*1，最后一位是corr中最新的那个
        u = z./diag(D);
%         u = [zeros(size(L,1)-1,1); corr(new_index)];
        d = linsolve(L,u,opts_upper);
        x(active_set) = x(active_set) + d;
        
        v = A(:, active_set)*d;         %At*(At'*At)'*At'*y
        r = r - v;
%         r = y - A(:,active_set) * x(active_set);

%         d_history = [[d_history;zeros(1,t-1)] d];
%         x_history = [[x_history;zeros(1,t-1)] x(active_set)];
%         r_history = [r_history r];
    end
     
    switch stopping_criterion
        case STOPPING_SUBGRADIENT
            error('Subgradient is not a valid stopping criterion for OMP.');
        case STOPPING_DUALITY_GAP
            error('Duality gap is not a valid stopping criterion for OMP.');
        case STOPPING_SPARSE_SUPPORT
            error('Sparse support is not a valid stopping criterion for OMP.');
        case STOPPING_OBJECTIVE_VALUE
            norm_res = norm(r);
            relative_res = norm_res/norm(y);
            if ((norm_res <= tolerance) || ((lambda > 0) && (maxcorr <= lambda)))
                done = 1;
            end
        case STOPPING_GROUND_TRUTH
            done = norm(xG-x)<tolerance;
        otherwise
            error('Undefined stopping criterion');
    end

    if verbose           
            disp(['Relative Residue: ' num2str(relative_res) ]);
    end
    t = t+1;
   
end

t = t-1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

