# Answers to Comments
We would like to thank you for your valuable comments. We will revise the submitted paper according to these comments. In this document, we summarize the answers to the comments and attempt to clarify the points addressed by each reviewer. 
## Reviewer #1:
OVERALL SCORE 7 Accept
### [Questions]: 
1.	More mathematical explanation is needed for the good performance on Image Compression.  
**Answer:** Thank you. We will extend the part of mathematical explanation later. It is indicated in the paper of Numax and Adagio that, given a training set and a determined compression rate, the data driven approach is more robust than the traditional random approach, as long as that the test image has the same noise as the training image. For the application of *stationary* wireless surveillance cameras, this assumption is usually satisfied; therefore, the data driven approach like the CCN may outperform the traditional methods.

2.	Why the CCN can beat all the baselines?  
**Answer:** From an experimental perspective, the traditional CS approach uses random embedding matrix, which are generally less incoherent (coherence measurement=1.96e+04) with the basis matrix than the optimized matrix calculated by the CCN (coherence measurement=2.5e+03). As a result, the CCN outperforms the traditional CS in terms of PSNR given the same compression rate (Figure 6).
The CCN also outperforms the data driven approaches. One important reason is that the Numax and Adagio assume that the samples distribute over a manifold, which may not be hold over high dimensional complicated image datasets. So they may lead to suboptimal results.


3. Also, why adding the regularization doesn't hurt the object detection performance.  
**Answer:** Technically, we adopted a two-stage training strategy to compensate the accuracy loss as mentioned in the paper. Please check the last paragraph of Model Implementation subsection (page4).  
   
## Reviewer #2:  
OVERALL SCORE 5 Marginally below threshold  
### [Questions]:  
1.	What's the applications of a system like Figure 2? Can you provide some concrete and critical examples? My major concern is that the user cases are rare, and this paper does not list related applications to this problem.   
**Answer:** Thank you for your kind reminding. We plan to extend the application background in the revised paper. One important application scenario of the CCN is smart wireless surveillance camera (rebuttal figure 1, see the full version). The smart cameras are a new type of device that can perform object detection on the edge side. Meanwhile, it is usually required to compress the video images before wireless transmission. Another application scenario is the smart UAV with wireless camera, which has similar functions of edge based object detection and image compression.
<table>
    <tr>
        <td ><center><img src="https://github.com/sosaaaad2/Rebuttal/blob/master/images/wireless_camera.jpg?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMzODI2NTY0/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70" >
        <td ><center><img src="https://github.com/sosaaaad2/Rebuttal/blob/master/images/timg.jpg?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMzODI2NTY0/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70"  >
    </tr>
</table>
                                     <p align="center">Rebuttal Fig. 1</p>

2.	The method used in this paper is not novel. Basically it follows the multi-task learning and transfer learning settings. The major novel of this paper lies in the problem, however, I am still skeptical about the importance of this problem.  
**Answer:** About the methodology innovation, in fact, transfer learning or multi-task learning are not the main contributions of this article. The novel contribution and benefits of the CCN are as follows:
     1)	A novel weighted L1 norm based regularization is proposed to enable the convolution operation for unified feature extraction and image compression. Through minimizing coherence, the CCN achieved better PSNR than the standard compressive sensing approach.
     2)	The CCN is the first data-driven compressive sensing approach that can be applied over large-scale dataset.
     3)	Since the CCN reuses the convolution operation for near-isometric image compression, it suffers no loss of computational efficiency. Therefore, it can perform object detection and image compression at speed of 40 frames per second on a regular computer.

## Reviewer #3:  
OVERALL SCORE 7 Accept  
### [Questions]:   
1.	The authors show that CCN doesn’t affect inference efficiency and almost no loss of detection accuracy. It is somehow a conflict with the target problem.  
**Answer:** Thank you for the good question. The CCN optimized and replaced the convolutional kernels of the original YOLO, but the inference pipeline for object detection, which has the longest latency, is not changed. Though a relatively small amount of computation is required for I/O and random pooling, they can be executed in parallel with object detection; therefore, the system achieved almost the same FPS as the original YOLOv2 in our experiment.

2.	In the second paragraph of Model Implementation, please introduce the function of YOLOv2 briefly.    
**Answer:** Thank you for your suggestion, we will revise the paper as suggested in further revision.

3.	The cost of CCN is not reduced compared with the original CNN model, which means the running time is limited by the current CNN model.   
**Answer:** Yes, you are perfectly right. The speed of the CCN model is limited by the basis CNN model. To further improve throughput, one can easily apply the incoherence regularization and our strategy to more efficient CNN models, e.g. the TINY-YOLO or quantized CNN models. This is also an important aspect for our future work.

4.	The dataset of BSD100 is small and it has no test set. The authors are suggested to provide explanations or choose other standard datasets.  
**Answer:** Thank you for your suggestions. We choose to use the BSD100 dataset because the compared Numax and Adagio are computational expensive. They cannot be trained over the large-scale COCO and VOC datasets on a regular computer. 

5.	The following are minor ones for further revisions:  
Occasionally, I noticed several typos, please correct them before the next submission.   
a) For example, in equation 4, the position of vector 0 and scalar 0 are strange. 
b) Spaces are required before the second and the third paragraph in Background and the third paragraph in Incoherence Regularization.
c) In table 4, the training set can be mentioned once, that will make the table more concise.
d) It is not professional to provide a code link in the abstract, and is better to put it as a URL reference or a footnote.
e) In equation (3), the dimensional of left value is N while the dimension of y is M. Please revise accordingly.    
**Answer:** Thank you for your suggestion, we will revise the paper as suggested in further revision.
***

# Introuduction of the demo
This is the demo software for the paper An Efficient Compressive Convolutional Network for Unified Object Detection and Image Compression.  
The demo consists of two parts, that is the front-end software for object detection and image compression, and the back-end software for image reconstruction and analysis. The front-end software is implemented based on YOLOv2 using C, and back-end software is implemented using matlab.   

# Abstract
This project addresses the challenge of designing efficient framework for real-time object detection and image compression. The proposed Compressive Convolutional Network (CCN) is basically a compressive-sensing-enabled convolutional neural network. Instead of designing different components for compressive sensing and object detection, the CCN optimizes and reuses the convolution operation for recoverable data embedding and image compression. Technically, the incoherence condition, which is the sufficient condition for recoverable data embedding, is incorporated in the first convolutional layer of the CCN model as regularization; Therefore, the CCN convolution kernels learned by training over the VOC and COCO image set can be used for data embedding and image compression. By reusing the convolution operation, no extra computational overhead is required for image compression. As a result, the CCN is 3.1 to 5.0 fold more efficient than the conventional approaches. In our experiments, the CCN achieved 78.1 mAP for object detection and 3.0 dB to 5.2 dB higher PSNR for image compression than the examined compressive sensing approaches.   

# Installation and Usage  

## FrontEnd_Detection&Compression

      1.Download the software in the folder of FrontEnd_Detection&Compression, download weights in https://pan.baidu.com/s/11r6Kwxs_gMq6bxPTugE1SA, and put it in CCN_demo folder. 
      2.Install the software as:
            cd FrontEnd_Detection&Compression
            make
      3.Run the front-end software for objection detection and image compression by:
            ./darknet detect cfg/yolo.cfg yolo_2002900.weights data/dog.jpg

NOTE: The front-end software is implemented based on YOLO model. We modified the code for model training over both CPU and GPU devices. The weights of the proposed CCN has been uploaded(xxx), but one can train your own CCN model from scratch by the same instructions at:  
https://pjreddie.com/darknet/yolov2/  


## BackEnd_Reconstruction&Analysis
The back-end software contains code for image reconstruction,   
you can run the code as follows in CCN_demo folder:  

      1.change path to CCN_demo folder
      2.run demo.m
if it works successfully, you can see the result:
![Alt text](https://github.com/sosaaaad2/CCN/blob/master/CCN_demo/src/cat.jpg)  
Demo proposed four compression method to compared with CCN approach.   
NOTE:This matlab evaluation program may take about 10 minutes to run on an average computer.
