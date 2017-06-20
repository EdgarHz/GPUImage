#import "PerfectFaceFilterViewController.h"
#import <AssetsLibrary/ALAssetsLibrary.h>


@implementation PerfectFaceFilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionFront];


    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    videoCamera.horizontallyMirrorFrontFacingCamera = NO;
    videoCamera.horizontallyMirrorRearFacingCamera = NO;
    GPUImageView *filterView = (GPUImageView *)self.view;

    faceFilter = [[GPUImagePerfectFaceFilter alloc] init];
    GPUImageOutput<GPUImageInput>* internalFilter = faceFilter;

    [videoCamera addTarget:internalFilter];
    [internalFilter addTarget:filterView];
    [videoCamera startCameraCapture];
    [(UILabel*)[self.view viewWithTag:11] setText:[@"" stringByAppendingFormat:@"%f",faceFilter.bilateralFilter.distanceNormalizationFactor]];
    [(UILabel*)[self.view viewWithTag:12] setText:[@"" stringByAppendingFormat:@"%f", faceFilter.GaussianCopyFilter1.blurRadiusInPixels]];
    [(UILabel*)[self.view viewWithTag:13] setText:[@"" stringByAppendingFormat:@"%f", faceFilter.GaussianFilter.blurRadiusInPixels]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    // Map UIDeviceOrientation to UIInterfaceOrientation.
    UIInterfaceOrientation orient = UIInterfaceOrientationPortrait;
    switch ([[UIDevice currentDevice] orientation])
    {
        case UIDeviceOrientationLandscapeLeft:
            orient = UIInterfaceOrientationLandscapeLeft;
            break;

        case UIDeviceOrientationLandscapeRight:
            orient = UIInterfaceOrientationLandscapeRight;
            break;

        case UIDeviceOrientationPortrait:
            orient = UIInterfaceOrientationPortrait;
            break;

        case UIDeviceOrientationPortraitUpsideDown:
            orient = UIInterfaceOrientationPortraitUpsideDown;
            break;

        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationFaceDown:
        case UIDeviceOrientationUnknown:
            // When in doubt, stay the same.
            orient = fromInterfaceOrientation;
            break;
    }
    videoCamera.outputImageOrientation = orient;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES; // Support all orientations.
}
- (IBAction)updateNormalizationValue:(UIStepper*)sender {
    NSLog(@"normalization:%f", sender.value); //<0, ghosting, virtual  > 4, more real
    faceFilter.bilateralFilter.distanceNormalizationFactor = sender.value;
     [(UILabel*)[self.view viewWithTag:11] setText:[@"" stringByAppendingFormat:@"%f", sender.value]];
}
- (IBAction)updateBlur0Value:(UIStepper*)sender {
    NSLog(@"blur0:%f", sender.value); //no effect
    faceFilter.GaussianCopyFilter1.blurRadiusInPixels= sender.value;
     [(UILabel*)[self.view viewWithTag:12] setText:[@"" stringByAppendingFormat:@"%f", sender.value]];
}

- (IBAction)updateBlur1Value:(UIStepper*)sender
{
    NSLog(@"blur1:%f", sender.value); //0-4, it's good.
    faceFilter.GaussianFilter.blurRadiusInPixels= sender.value;
     [(UILabel*)[self.view viewWithTag:13] setText:[@"" stringByAppendingFormat:@"%f", sender.value]];
}

@end
