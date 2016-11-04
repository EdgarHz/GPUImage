#import <UIKit/UIKit.h>
#import "GPUImage.h"

@interface PerfectFaceFilterViewController : UIViewController
{
    GPUImageVideoCamera *videoCamera;
    GPUImagePerfectFaceFilter* faceFilter;
    GPUImageMovieWriter *movieWriter;
}

- (IBAction)updateSliderValue:(id)sender;

@end
