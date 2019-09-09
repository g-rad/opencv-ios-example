#import "ViewController.h"
#import <opencv2/videoio/cap_ios.h>

@interface ViewController ()<CvVideoCameraDelegate>
@property (strong, nonatomic) CvVideoCamera *videoCamera;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:self.imgDisplay];
    [self.videoCamera setDelegate:self];
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPresetHigh;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = 30;
    self.videoCamera.useAVCaptureVideoPreviewLayer = YES;
}

- (IBAction)actionStart:(id)sender {
    [self.videoCamera start];
}

- (void)processImage:(cv::Mat &)image;
{
    cv::Mat image_copy;
    cvtColor(image, image_copy, CV_BGRA2BGR);
    bitwise_not(image_copy, image_copy);
    cvtColor(image_copy, image, CV_BGR2BGRA);
}

@end
