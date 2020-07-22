# BAL
# Bayesian Active Learning for Remote Sensing

A Matlab program that implements a Bayesian Active Learning (BAL) method applied to Remote Sensing images.

## Abstract

This a MATLAB demo for implementing the Bayesian Active Learning for Remote Sensing algorithm in the paper:

P. Ruiz, J. Mateos, G. Camps-Valls, R. Molina, and A.K. Katsaggelos, "Bayesian Active Remote Sensing Image Classification", IEEE Transactions on Geoscience and Remote Sensing, vol. 52, no. 4, 2186-2196, April 2014. [[![DownloadPDF](http://decsai.ugr.es/vip/images/pdficon.gif)(3804 KB.)](http://decsai.ugr.es/vip/files/journals/TGSRS13_BALRS.pdf)]

## Video Demostration

[![Bayesian Active Learning demonstration](http://decsai.ugr.es/vip/resources/BAL/thumbnail.png)](http://vimeo.com/38813135 "Bayesian Active Learning demonstration - Click to Watch!")

## How it works 

Please take a look at the file "demo_BAL.m", which automatically runs 
the different methods implemented. 

The demo loads the learning dataset, the pool set and the 
test dataset and runs the BAL_GP function with differente parameters.
The BAL_GP function performs the training, test and Active learning
procedures. See the journal paper for the details.

## Files description 
- assessment.m		Assessing the Accuracy of Remotely Sensed Data
- BAL_GP.m			Main procedure.
- kernelmatrix.m 		Computes the (training or testing) kernel matrices fast.
- estimate_params.m	Parameter estimation procedure.

## Disclaimer

The programs are granted free of charge for research and education purposes only. Scientific results produced using the software provided shall acknowledge the use of the BAL implementation provided by us. If you plan to use it for non-scientific purposes, don't hesitate to contact us.

Because the programs are licensed free of charge, there is no warranty for the program, to the extent permitted by applicable law. except when otherwise stated in writing the copyright holders and/or other parties provide the program "as is" without warranty of any kind, either expressed or implied, including, but not limited to, the implied warranties of merchantability and fitness for a particular purpose. the entire risk as to the quality and performance of the program is with you. should the program prove defective, you assume the cost of all necessary servicing, repair or correction.

In no event unless required by applicable law or agreed to in writing will any copyright holder, or any other party who may modify and/or redistribute the program, be liable to you for damages, including any general, special, incidental or consequential damages arising out of the use or inability to use the program (including but not limited to loss of data or data being rendered inaccurate or losses sustained by you or third parties or a failure of the program to operate with any other programs), even if such holder or other party has been advised of the possibility of such damages. 
