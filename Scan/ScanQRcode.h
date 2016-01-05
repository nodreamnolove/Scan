//hmh


#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface ScanQRcode : UIViewController<AVCaptureMetadataOutputObjectsDelegate,UIWebViewDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
}
@property (strong,nonatomic)    AVCaptureDevice            * device;
@property (strong,nonatomic)    AVCaptureDeviceInput       * input;
@property (strong,nonatomic)    AVCaptureMetadataOutput    * output;
@property (strong,nonatomic)    AVCaptureSession           * session;
@property (strong,nonatomic)    AVCaptureVideoPreviewLayer * preview;
@property (strong,nonatomic)    UIImageView                * line;
@end
