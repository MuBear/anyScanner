//
//  QRDecoderViewController.m
//  ticket_back
//
//  Created by Funwish on 13/3/25.
//  Copyright (c) 2013年 Funwish. All rights reserved.
//

#import "QRDecoderViewController.h"
#import "imgLib.h"

@interface QRDecoderViewController ()

@end

@implementation QRDecoderViewController
@synthesize readerView;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}


//按了閃光燈的判斷
- (IBAction)PressFlash:(id)sender
{
    if ([imgLib flashAvailable]) {

        if(self.readerView.torchMode == AVCaptureTorchModeOff)
        {
            [flashBtn setBackgroundImage:[UIImage imageNamed:@"S4_FlashOff"] forState:UIControlStateNormal];
            flashBtn.frame = CGRectMake(280, self.view.bounds.size.height-140, 26.5, 25.5);
            self.readerView.torchMode = AVCaptureTorchModeOn;
        }
        else
        {
            [flashBtn setBackgroundImage:[UIImage imageNamed:@"S4_FlashOn"] forState:UIControlStateNormal];
            flashBtn.frame = CGRectMake(280, self.view.bounds.size.height-140, 13.5, 23);
            self.readerView.torchMode = AVCaptureTorchModeOff;
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"Alert", @"InfoPlist", nil)
                                                        message:NSLocalizedStringFromTable(@"FlashCantUse", @"InfoPlist", nil)
                                                       delegate:nil
                                            cancelButtonTitle:NSLocalizedStringFromTable(@"Ok", @"InfoPlist", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) init_camera
{
    //CGRect screenBounds = [[UIScreen mainScreen] bounds];
    //初始化barCode Scan
    self.readerView = [ZBarReaderView new];
    ZBarImageScanner * scanner = [ZBarImageScanner new];
    [scanner setSymbology:ZBAR_PARTIAL config:0 to:0];
    [self.readerView initWithImageScanner:scanner];
    self.readerView.readerDelegate = self;
    self.readerView.torchMode = AVCaptureTorchModeOff;

    self.readerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.readerView.backgroundColor = [UIColor redColor];
    [self.readerView start];
    
    [self.view addSubview: self.readerView];
    
    //flashbtn
//    UIImage *flashImg = [UIImage imageNamed:@"S4_FlashOn"];
//    flashBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
//    flashBtn.frame = CGRectMake(280, self.view.bounds.size.height-140-44, 13.5, 23);
//    [flashBtn setBackgroundImage:flashImg forState:UIControlStateNormal];
//    [flashBtn addTarget:self action:@selector(PressFlash:) forControlEvents:UIControlEventTouchDown];
//    [self.view addSubview:flashBtn];

}

- (void) readerView:(ZBarReaderView *)readerView didReadSymbols: (ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    ZBarSymbol * s = nil;
    for (s in symbols)
        break;
    NSLog(@"sdata:%@",s.data);
    //導到網頁
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:s.data]];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    [self init_camera];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
