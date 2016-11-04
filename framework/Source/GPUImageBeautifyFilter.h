//
//  GPUImageBeautifyFilter.h
//  BeautifyFaceDemo
//
//  Created by guikz on 16/4/28.
//  Copyright © 2016年 guikz. All rights reserved.
//

#import "GPUImageBilateralFilter.h"
#import "GPUImageHSBFilter.h"
#import "GPUImageCannyEdgeDetectionFilter.h"


@class GPUImageCombinationFilter;

@interface GPUImageBeautifyFilter : GPUImageFilterGroup {
    GPUImageBilateralFilter *bilateralFilter;
    GPUImageCannyEdgeDetectionFilter *cannyEdgeFilter;
    GPUImageCombinationFilter *combinationFilter;
    GPUImageHSBFilter *hsbFilter;
}

@property (nonatomic, assign) float whitening; ///<default: 1.1, shouldn't be 0, which will make black screen
@property (nonatomic, assign) float saturation;//default: 1.1, shouldn't be 0, which will make black screen
@property (nonatomic, assign) CGFloat smoothIntensity;//default: 0.5
@end
