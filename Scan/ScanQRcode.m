//hmh

#import "ScanQRcode.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
@interface ScanQRcode ()

@end

@implementation ScanQRcode
int height;
int width;
int height2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupCamera];
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    if (SCREENHEIGHT > 1000) {
        height = 250;
        width = 140;
        height2 = 500;
        [view setImage:[UIImage imageNamed:@"scanBigPhone"]];
    }
    else {
        height = 180;
        width = 50;
        height2 = 200;
        [view setImage:[UIImage imageNamed:@"scanBigPad"]];
    }
    [self.view addSubview:view];
    
	UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [scanButton setBackgroundImage:[UIImage imageNamed:@"closeBtn"] forState:UIControlStateNormal];
    scanButton.frame = CGRectMake(10, 20, 30, 30);
    [scanButton addTarget:self action:@selector(exitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanButton];
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(30, 70+40, SCREENWIDTH-60, 50)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=2;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.text=@"将二维码置于相框内";
    [self.view addSubview:labIntroudction];
    

    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(width, height, SCREENWIDTH-2*width, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
  
    

}
-(void)scanStategy:(id)sender{

}
-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(width, height+2*num, SCREENWIDTH-2*width, 2);
        if (2*num == height2) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(width, height+2*num, SCREENWIDTH-2*width, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }

}
-(void)exitClick
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        [timer invalidate];
    }];
}

//设置相机类型
- (void)setupCamera
{

    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =CGRectMake(0,0,SCREENWIDTH,SCREENHEIGHT);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    
    // Start
    [_session startRunning];
  
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
   
    NSString *scanString = @"";
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        scanString = metadataObject.stringValue;
    }
    
    [_session stopRunning];
    
    [timer invalidate];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
