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

