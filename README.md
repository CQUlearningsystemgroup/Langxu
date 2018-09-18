# Introuduction
This is the demo software for the paper An Efficient Compressive Convolutional Network for Unified Object Detection and Image Compression.  
The demo consists of two parts, that is the front-end software for object detection and image compression, and the back-end software for image reconstruction and analysis. The front-end software is implemented based on YOLOv2 using C, and back-end software is implemented using matlab.   

# Abstract
This project addresses the challenge of designing efficient framework for real-time object detection and image compression. The proposed Compressive Convolutional Network (CCN) is basically a compressive-sensing-enabled convolutional neural network. Instead of designing different components for compressive sensing and object detection, the CCN optimizes and reuses the convolution operation for recoverable data embedding and image compression. Technically, the incoherence condition, which is the sufficient condition for recoverable data embedding, is incorporated in the first convolutional layer of the CCN model as regularization; Therefore, the CCN convolution kernels learned by training over the VOC and COCO image set can be used for data embedding and image compression. By reusing the convolution operation, no extra computational overhead is required for image compression. As a result, the CCN is 3.1 to 5.0 fold more efficient than the conventional approaches. In our experiments, the CCN achieved 78.1 mAP for object detection and 3.0 dB to 5.2 dB higher PSNR for image compression than the examined compressive sensing approaches.   

# Installation and Usage  

## FrontEnd_Detection&Compression

      1.Download the software in the folder of FrontEnd_Detection&Compression. 
      2.Install the software as:
            cd FrontEnd_Detection&Compression
            make
      3.Run the front-end software for objection detection and image compression by:
            ./darknet detect cfg/yolo.cfg backup/1 rate cpu v2/yolo_2002900.weights data/dog.jpg

NOTE: The front-end software is implemented based on YOLO model. We modified the code for model training over both CPU and GPU devices. The weights of the proposed CCN has been uploaded(xxx), but one can train your own CCN model from scratch by the same instructions at:  
https://pjreddie.com/darknet/yolov2/  


## BackEnd_Reconstruction&Analysis
The back-end software contains code for image reconstruction,   
you can run the code as follows:  

      1.change path to CCN_demo folder
      2.run demo.m
if it works successfully, you can see the result:
![Alt text](https://github.com/sosaaaad2/CCN/blob/master/CCN_demo/src/cat.jpg)  
Demo proposed four compression method to compared with CCN approach.   
NOTE:This matlab evaluation program may take about 10 minutes to run on an average computer.
