function [gamma, sigma,Cinv,iter] = estimate_params(FF,T2,gamma,sigma,b,tol,maxip)
%
% Parameter estimation procedure for the Bayesian Active Learning for 
% Remote Sensing algorithm in the paper:
% P. Ruiz, J. Mateos, G. Camps-Valls, R. Molina, and A.K. Katsaggelos,
% “Bayesian Active Remote Sensing Image Classification”, 
% IEEE Transactions on Geoscience and Remote Sensing, vol. 52, 
% no. 4, 2186-2196, April 2014.
%
% INPUTS:
%
%   FF: kernel matrix.
%   T2:  Training set.
%   gamma: Current value of the prior standard deviation
%   sigma: Current value of the noise standard deviation
%   b: bias in the classification function
%   tol: threshold for the stopping criterium.
%        the algoritms will stop if (par-par_old)^2/par_old^2 < tol
%        where par is the new value of a parameter (gamma or sigma) and 
%        par_old is the old value of a parameter (gamma or sigma)
%   maxip: Maximum number of iterations.      
% 
% OUTPUTS:
%   
%   gamma: New value of the prior standard deviation
%   sigma: New value of the noise standard deviation
%   Cinv: Inverse matrix of C
%   iter: number of iterations at convergence
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



N =size(T2,1);
iter=0;

[U,D] = eig(FF);
U=real(U);
lambda= real(diag(D));

z2 = U'*(T2-repmat(b,N,1)); 

z2 = z2.*z2;

thrgamma = 1;
thrsigma = 1;

while ((thrgamma > tol) || (thrsigma > tol)) && (iter < maxip) 
    
    gammaold = gamma;
    
    vector = 1./(gamma*lambda+sigma);
    lambdavector = vector.*lambda;
    
    nume = sum(gamma.*z2.*vector.*lambdavector);
    deno = sum(lambdavector);
    
    gamma = nume/deno;
    
    thrgamma= (gamma-gammaold)^2/gammaold^2;
    
    sigmaold = sigma;
    
    vector = 1./(gammaold*lambda+sigma);
        
    nume = sum(sigma.*z2.*vector.*vector);
    deno = sum(vector);
       
    sigma = nume/deno;
    
    thrsigma= (sigma-sigmaold)^2/sigmaold^2;
    iter=iter+1;
end

D = diag(1./(gamma*lambda+sigma));
Cinv = U*D*U';
