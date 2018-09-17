# CCN
demo of paper{An Efficient Compressive Convolutional Network for Unified \\ Object Detection and Image Compression}  
## FrontEnd_Detection&Compression  



## BackEnd_Reconstruction&Analysis
This folder is the demo that shows how our model works;  
you can run as follows:  

      1.open demo.m in matlab
      2.change path to CCN_demo folder
      3.run the program
if it works successfully, you can see the result:
![Alt text](https://github.com/sosaaaad2/CCN/blob/master/CCN_demo/src/cat.jpg)  
Demo proposed four compression method to compared with CCN approach.   
*ccn.m, adagio.m, randconv.m, SparseRandomMtx.m* is the function of CCN, ADAGIO, Random Convolution, CS-SM, and Gaussian matrix are generate using matlab randn.  *recons2.m,recons3.m* are reconstruction omp algorithm.
This matlab program is using CPU without any optimization, and reconstruct a 24 bit image in 5 methods, so it may take about 10 minutes.
