//
//  imgLib.h
//  NewTicket_back
//
//  Created by Funwish on 13/6/20.
//  Copyright (c) 2013年 Yilan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface imgLib : NSObject

+ (UIImage *) imageFromURLString: (NSString *) urlstring;
+ (int) numberOfCameras;
+ (BOOL) backCamerAvailable;
+ (BOOL) frontCameraAvailable;
+ (AVCaptureDevice *) backCamera;
+ (AVCaptureDevice *) frontCamera;
+ (BOOL) flashAvailable;

@end
