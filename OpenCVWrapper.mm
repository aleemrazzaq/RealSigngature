//
//  OpenCVWrapper .m
//  HandSignatureViaOpenCV
//
//  Created by Ascertia-ZA on 02/09/2019.
//  Copyright © 2019 Ascertia. All rights reserved.
//
#import <opencv2/opencv.hpp>
#import "OpenCVWrapper.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <opencv2/imgcodecs/ios.h>
#import <opencv2/imgproc/imgproc.hpp>

@implementation OpenCVWrapper


+ (cv::Mat)inverseMatConversion:(cv::Mat)inputMat
{
    cv::cvtColor(inputMat, inputMat, CV_BGRA2BGR);
    cv::Mat invertMat =  cv::Mat(inputMat.rows, inputMat.cols, inputMat.type());
    
    // invert image
    cv::bitwise_not(inputMat, invertMat);
    cv::cvtColor(invertMat, invertMat, CV_BGR2BGRA);
    inputMat.release();
    return invertMat;
}

+ (UIImage *)convertToBlack:(UIImage *)image {

    cv::Mat imageMat ;
    cv::Mat orgImage ;
    UIImageToMat(image,imageMat,YES);
    UIImageToMat(image,orgImage,YES);
    cv::cvtColor(imageMat, imageMat, CV_BGR2GRAY);
    cv::threshold(imageMat, imageMat, 127, 255, cv::THRESH_BINARY_INV);
    cv::cvtColor(imageMat, imageMat, CV_GRAY2BGRA);
    
    cv::bitwise_and(imageMat, orgImage, orgImage);
    UIImage *outputImage = MatToUIImage(orgImage);
    return outputImage;
}


+ (UIImage *)convertBlackTransparent:(UIImage *)image {
    
    image = [OpenCVWrapper convertToBlack:image];
    cv::Mat src = cv::Mat(image.size.width, image.size.height, CV_8UC4);
     UIImageToMat(image,src,YES); //[OpenCVWrapper cvMatFromUIImage:image];

    //init new matrics
    cv::Mat dst = cv::Mat(image.size.width, image.size.height, CV_8UC4);
    cv::Mat tmp = cv::Mat(image.size.width, image.size.height, CV_8UC4);
    cv::Mat alpha = cv::Mat(image.size.width, image.size.height, CV_8UC4);
    
    // convert image to grayscale
    
    cv::cvtColor(src, tmp, CV_BGR2GRAY);//COLOR_BGR2GRAY
    
    // threshold the image to create alpha channel with complete transparency in black background region and zero transparency in foreground object region.
    cv::threshold(tmp, alpha, 130, 255, cv::THRESH_TRIANGLE);

    // split the original image into three single channel.
    cv::Mat rgb[4];
    cv::split(src, rgb);
    
    // Create the final result by merging three single channel and alpha(BGRA order)
    cv::Mat rgba[4];
    rgba[0] = rgb[0];
    rgba[1] = rgb[1];
    rgba[2] = rgb[2];
    rgba[3] = alpha;
    int size = 4;
    cv::merge(rgba,size,dst);

    // convert matrix to output image
    UIImage *outputImage = MatToUIImage(dst);//
    return outputImage;

}


@end
