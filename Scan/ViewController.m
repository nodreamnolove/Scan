//
//  ViewController.m
//  Scan
//


#import "ViewController.h"
#import "ScanQRcode.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *scanBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [scanBtn setTitle:@"扫描" forState:UIControlStateNormal];
    [scanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    scanBtn.center = self.view.center;
    [scanBtn addTarget:self action:@selector(jumpScan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanBtn];
}

-(void)jumpScan
{
    ScanQRcode *scanVC = [ScanQRcode new];
    [self presentViewController:scanVC animated:YES completion:nil];
}

@end
