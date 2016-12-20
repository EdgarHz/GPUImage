#import <UIKit/UIKit.h>
#import "GPUImage.h"

@interface SimpleVideoFilterViewController : UIViewController
{
    GPUImageVideoCamera *videoCamera;
    GPUImageBeautifyFilter *filter;
    GPUImageMovieWriter *movieWriter;
    GPUImageRawDataOutput* rawDataOutput;
    CVPixelBufferRef pixelBuffer;
}

//- (IBAction)updateSliderValue:(id)sender;
- (IBAction)rotateCamera:(id)sender;
@end
