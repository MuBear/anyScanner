//
//  imgLib.m
//  NewTicket_back
//
//  Created by Funwish on 13/6/20.
//  Copyright (c) 2013年 Yilan. All rights reserved.
//

#import "imgLib.h"

@implementation imgLib

+ (UIImage *) imageFromURLString: (NSString *) urlstring
{
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlstring]]];
}

+ (int) numberOfCameras
{
    return [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo].count;
}

+ (BOOL) backCamerAvailable
{
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in videoDevices)
        if (device.position == AVCaptureDevicePositionBack) return YES;
    return NO;
}

+ (BOOL) frontCameraAvailable
{
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in videoDevices)
        if (device.position == AVCaptureDevicePositionFront) return YES;
    return NO;
}

+ (BOOL) flashAvailable
{
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in videoDevices)
        if (device.isFlashAvailable) return YES;
    return NO;
}

+ (AVCaptureDevice *) backCamera
{
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for(AVCaptureDevice *device in videoDevices)
        if(device.position == AVCaptureDevicePositionBack)
            return device;
    
    return [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
}

+ (AVCaptureDevice *) frontCamera
{
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for(AVCaptureDevice *device in videoDevices)
        if(device.position == AVCaptureDevicePositionFront)
            return device;
    
    return [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
}
@end
