#import "SimpleVideoFilterViewController.h"
#import <AssetsLibrary/ALAssetsLibrary.h>

@implementation SimpleVideoFilterViewController

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


    filter = [[GPUImageBeautifyFilter alloc] init];
    GPUImageOutput<GPUImageInput>* internalFilter = filter;

    [videoCamera addTarget:internalFilter];
    [internalFilter addTarget:filterView];
    [videoCamera startCameraCapture];
    

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
    //0-4; < 0, virtual;  > 4, real;
    NSLog(@"Normalization:%f", sender.value);
    [filter.bilateralFilter setDistanceNormalizationFactor:[sender value]];
    [(UILabel*)[self.view viewWithTag:11] setText:[@"" stringByAppendingFormat:@"%f", sender.value]];
}
- (IBAction)updateWhiteningValue:(UIStepper*)sender {
    //whitening,0-0.9; <0, blank. > 1, it's to bright.
    NSLog(@"whitening:%f", sender.value);
    [filter setWhitening:[sender value]];
    [(UILabel*)[self.view viewWithTag:12] setText:[@"" stringByAppendingFormat:@"%f", sender.value]];
}
- (IBAction)updateSaturationValue:(UIStepper*)sender {
    //Saturation, 0-3; < 0, blue face, red hair; > 3; red face, blue hair.
    NSLog(@"saturation:%f", sender.value);
    [filter setSaturation:[sender value]];
    [(UILabel*)[self.view viewWithTag:13] setText:[@"" stringByAppendingFormat:@"%f", sender.value]];
}
- (IBAction)updateSmoothValue:(UIStepper*)sender
{
    //smooth, 0-2.5; < 0, the pores; > 2.5 wrinkle
    NSLog(@"smooth:%f", sender.value);
    [filter setSmoothIntensity:[sender value]];
    [(UILabel*)[self.view viewWithTag:14] setText:[@"" stringByAppendingFormat:@"%f", sender.value]];
}

@end
