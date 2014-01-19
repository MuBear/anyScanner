//
//  QRDecoderViewController.h
//  ticket_back
//
//  Created by Funwish on 13/3/25.
//  Copyright (c) 2013年 Funwish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface QRDecoderViewController : UIViewController<ZBarReaderViewDelegate>
{
    UIImageView *underView;
    UILabel *instructionLabel;
    UIImageView *resultImageView;
    ZBarReaderView * readerView;
    UIButton *flashBtn;
}

@property (nonatomic, strong) ZBarReaderView * readerView;

@end
