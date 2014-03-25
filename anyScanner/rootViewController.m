//
//  rootViewController.m
//  anyScanner
//
//  Created by Kuan-Ting Lai on 2014/3/25.
//  Copyright (c) 2014年 Kuan-Ting Lai. All rights reserved.
//

#import "rootViewController.h"
#import <Crashlytics/Crashlytics.h>
#import "QRDecoderViewController.h"

@interface rootViewController ()

@end

@implementation rootViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)testCrash:(id)sender
{
    [[Crashlytics sharedInstance] crash];
}

- (IBAction)testExceptionCrash:(id)sender
{
    strcpy(0, "bla");
}

- (IBAction)enterScanner:(id)sender
{
    
    [self.navigationController pushViewController:[[QRDecoderViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
