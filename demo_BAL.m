% DEMO_BAL Bayesian Active Learning demonstration
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

clear all;clc;

load inputs.mat;

n_iter = 100; % number of Active Learning iterations
pts2add = ones(1,n_iter); % Add one sample in each iteration

%% Run the different proposed methods
[tstErr_maxvar,res_maxvar]  = BAL_GP(start_trset,pool_trset,valset,n_iter,pts2add, 'maxvar',100);
[tstErr_ms,res_ms]  = BAL_GP(start_trset,pool_trset,valset,n_iter,pts2add, 'ms',100);
[tstErr_norm,res_norm]  = BAL_GP(start_trset,pool_trset,valset,n_iter,pts2add, 'normalized',100);

%% show results in a figure
figure

subplot(1,2,1)
plot(tstErr_maxvar(:,1),'b','LineWidth',2);hold on;
plot(tstErr_ms(:,1),'g','LineWidth',2);
plot(tstErr_norm(:,1),'k','LineWidth',2); hold off
legend({'BAL-1','BAL-2','BAL-3'},4);
xlabel('Iterations');
ylabel('OA[%]')
grid on;

subplot(1,2,2)
plot(tstErr_maxvar(:,2),'b','LineWidth',2);hold on;
plot(tstErr_ms(:,2),'g','LineWidth',2);
plot(tstErr_norm(:,2),'k','LineWidth',2);hold off;
legend({'BAL-1','BAL-2','BAL-3'},4);
xlabel('Iterations');
ylabel('Kappa Index');
grid on;
