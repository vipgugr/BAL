function [tstErr,res]  = BAL_GP(trnSet,trnNo,valset,iterVect,pts2add, mode,stdzFin)
%
% This code implements the Bayesian Active Learning for Remote Sensing
% algorithm in the paper:
% P. Ruiz, J. Mateos, G. Camps-Valls, R. Molina, and A.K. Katsaggelos,
% “Bayesian Active Remote Sensing Image Classification”, 
% IEEE Transactions on Geoscience and Remote Sensing, vol. 52, 
% no. 4, 2186-2196, April 2014.
%
% INPUTS:
%
%   trnSet: Training set, each row contains a sample.
%   trnNo:  Pool set.
%   valset: Test set.
%   iterVect: number of Active Learning iterations.
%   pts2add: Vector of length iterVect where each component
%            is the number of samples to add in each Active Learning
%            iteration.
%   mode: Active Learning mode
%               Options: 'maxvar' 
%                        'ms'
%                        'normalized'
%               See [1] for more information.
%   stdzFin: Variance of Gaussian kernel.      
% 
% OUTPUTS:
%   
%   tstErr: Overall Accuracy and Kappa Index for each iteration.
%   res: Statistical classification results for each iteration.
%
% Author (aka person to blame): Pablo Ruiz, mataran@decsai.ugr.es
% Also: Javier Mateos, jmd@decsai.ugr.es
% Last modified by: 19/03/2012
%
% Copyright (c) 2012 Pablo Ruiz and Javier Mateos

% DISCLAIMER
% The programs are granted free of charge for research and education 
% purposes only. Scientific results produced using the software provided 
% shall acknowledge the use of the implementation provided by us. If you 
% plan to use it for non-scientific purposes, don't hesitate to contact us.
%
% Because the programs are licensed free of charge, there is no warranty 
% for the program, to the extent permitted by applicable law. except when 
% otherwise stated in writing the copyright holders and/or other parties 
% provide the program "as is" without warranty of any kind, either 
% expressed or implied, including, but not limited to, the implied 
% warranties of merchantability and fitness for a particular purpose. 
% The entire risk as to the quality and performance of the program is with 
% you. should the program prove defective, you assume the cost of all 
% necessary servicing, repair or correction.
%
% In no event unless required by applicable law or agreed to in writing 
% will any copyright holder, or any other party who may modify and/or 
% redistribute the program, be liable to you for damages, including any 
% general, special, incidental or consequential damages arising out of 
% the use or inability to use the program (including but not limited to 
% loss of data or data being rendered inaccurate or losses sustained by 
% you or third parties or a failure of the program to operate with any 
% other programs), even if such holder or other party has been advised 
% of the possibility of such damages. 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


gamma = 1;
sigma = 1;


tol =1e-6;
maxip = 10000;
ptsidx = 1;
kerneltype = 'rbf';

tr_labs = trnSet(:,end);
trnSet = trnSet(:,1:end-1);

trnNo_labs = trnNo(:,end);
trnNo = trnNo(:,1:end-1);

tstSet = valset;

for iteration = 1:iterVect

FF = kernelmatrix(kerneltype,trnSet',trnSet',stdzFin);

%% Training 
    b = mean(tr_labs);
       
    [gamma, sigma,Cinv,iter] = estimate_params(FF,tr_labs,gamma,sigma,b,tol,maxip);
    
%% Test
    Ypredic = zeros(length(tstSet),1);
    
    fF_test = kernelmatrix(kerneltype,tstSet(:,1:end-1)',trnSet',stdzFin);
    
    y = gamma*fF_test*Cinv*(tr_labs-repmat(b,size(trnSet,1),1)) + b;
    
   for i = 1:length(tstSet)
        if y(i) >= 0.5 
            Ypredic(i) = 1;
        end
    end        
    
    res(iteration) = assessment(tstSet(:,end),Ypredic,'class');
    tstErr(ptsidx,1) = res(iteration).OA;
    tstErr(ptsidx,2) = res(iteration).Kappa;
    fprintf('ITCN = %i \t OA = %.4f \t Kappa = %.4f \t gamma = %.4f \t sigma = %.4f \t iter = %i \n',[iteration, res(iteration).OA,res(iteration).Kappa,gamma,sigma,iter]);
    
    % Stop when we are in last iteration
    if iteration == iterVect
        break
    end
    
    
%% ACTIVE LEARNING
    
    fF_act = kernelmatrix(kerneltype,trnNo',trnSet',stdzFin);
    
    switch kerneltype
        case 'rbf'
            auxi = ones(size(trnNo,1),1); 
        case 'lin'
            auxi = dot(trnNo',trnNo')';
        otherwise
            auxi = diag(kernelmatrix(kerneltype,trnNo',trnNo',stdzFin));
    end
       
    aux = (gamma^2)*dot(fF_act',Cinv*fF_act')';
    variances = sigma + gamma*auxi - aux;
    
    distance = gamma*fF_act*Cinv*(tr_labs-repmat(b,size(trnSet,1),1)) + b;
    distance = abs(distance-0.5);
        
    switch mode 
        case 'maxvar'
            alf = variances;
            [val ptsList] = sort(alf,'descend');
        case 'ms'
            alf = distance;
            [val ptsList] = sort(alf,'ascend');
        case 'normalized'
            alf = distance.^2./variances;
            [val ptsList] = sort(alf,'ascend');
    end
            
    ptsNoList = ptsList((pts2add(ptsidx)+1):end);
    ptsList   = ptsList(1:pts2add(ptsidx));
    trnSet    = [trnSet ; trnNo(ptsList,:)];
    trnNo     = trnNo(ptsNoList,:);
    
    tr_labs = [tr_labs;trnNo_labs(ptsList,:)];
    trnNo_labs = trnNo_labs(ptsNoList,:);
    
    ptsidx = ptsidx + 1;
    
end