# Real Signature
Its wrapper for OpenCV, what it does, it get the real Signature from any image. It'll convert image into gray scale then convert background of image into transparent color, and then do the masking to back to real color of image, like blue pen signature on paper.

## How it Works

 - Get the Open cv framework with 3.4.7: https://sourceforge.net/projects/opencvlibrary/files/3.4.7/opencv-3.4.7-ios-framework.zip/download and Add into your Project.

 - Add the Wrapped class(OpenCVWrapper) into your project

 - #include "OpenCVWrapper.h" into your class 

 - use the following lines of code.

 UIImage * originalImage = [OpenCVWrapper convertBlackTransparent:originalImage];
 [self.imageView setImage:originalImage];




## Download the working Demo: https://drive.google.com/uc?id=1584Qm8BwNwu7pCLkLHfXNwSGSN-mtPv0&export=download
