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
{
    UIImageView *picView;
}

@property (nonatomic, retain) UIView *scanBar;

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
    //NSLog(@"pressFlash");
    if ([imgLib flashAvailable]) {

        if(self.readerView.torchMode == AVCaptureTorchModeOff)
        {
            [flashBtn setBackgroundImage:[UIImage imageNamed:@"S4_FlashOff"] forState:UIControlStateNormal];
            flashBtn.frame = CGRectMake(280, self.view.bounds.size.height-60-44, 26.5, 25.5);
            self.readerView.torchMode = AVCaptureTorchModeOn;
        }
        else
        {
            [flashBtn setBackgroundImage:[UIImage imageNamed:@"S4_FlashOn"] forState:UIControlStateNormal];
            flashBtn.frame = CGRectMake(280, self.view.bounds.size.height-60-44, 13.5, 23);
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
    self.readerView.userInteractionEnabled = YES;
    [self.readerView start];
    
    [self.view addSubview: self.readerView];
    
    //flashbtn
    UIImage *flashImg = [UIImage imageNamed:@"S4_FlashOn"];
    flashBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    flashBtn.frame = CGRectMake(280, self.view.bounds.size.height-60-44, 13.5, 23);
    [flashBtn setBackgroundImage:flashImg forState:UIControlStateNormal];
    [flashBtn addTarget:self action:@selector(PressFlash:) forControlEvents:UIControlEventTouchDown];
    [self.readerView addSubview:flashBtn];

    //TapGestureRecognizer
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                          initWithTarget:self
                                                          action:@selector(handleSingleTap:)];
    //[singleTapGestureRecognizer setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:singleTapGestureRecognizer];
    
    //longpress
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.view addGestureRecognizer:longPress];
    //即將彈出的picView
    picView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
}

//zbar回傳結果
- (void) readerView:(ZBarReaderView *)readerView didReadSymbols: (ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    ZBarSymbol * s = nil;
    for (s in symbols)
        break;
    NSLog(@"sdata:%@",s.data);
    //導到網頁
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:s.data]];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Data" message: s.data delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

//點一下
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    // Insert your own code to handle singletap
    NSLog(@"tap1");
    [self.readerView stop];
    picView.image = [UIImage imageNamed:@"zoro01.png"];
    picView.userInteractionEnabled = YES;
    picView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:picView];
    
    //close pic
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    closeBtn.backgroundColor = [UIColor clearColor];
    [closeBtn addTarget:self action:@selector(closeImg:) forControlEvents:UIControlEventTouchUpInside];
    [picView addSubview:closeBtn];
}


//長按
- (void)longPress:(UILongPressGestureRecognizer *)recognizer {
    // Insert your own code to handle singletap
    NSLog(@"tap1");
    [self.readerView stop];
    picView.image = [UIImage imageNamed:@"zoro02.png"];
    picView.userInteractionEnabled = YES;
    picView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:picView];
    
    //close pic
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    closeBtn.backgroundColor = [UIColor clearColor];
    [closeBtn addTarget:self action:@selector(closeImg:) forControlEvents:UIControlEventTouchUpInside];
    [picView addSubview:closeBtn];
}

//關閉imageView
-(IBAction)closeImg:(id)sender
{
    //移除UIimageView
    for (UIView *subView in self.view.subviews)
    {
        if([subView isKindOfClass:[UIImageView class]])
           [subView removeFromSuperview];
    }
    
    //重新啟動掃瞄
    [self.readerView start];
    
}

//uiAlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex == [alertView cancelButtonIndex]) {
        NSLog(@"The cancel button was clicked for alertView");
    }
    // else do your stuff for the rest of the buttons (firstOtherButtonIndex, secondOtherButtonIndex, etc)
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    [self init_camera];
    
}


@end
