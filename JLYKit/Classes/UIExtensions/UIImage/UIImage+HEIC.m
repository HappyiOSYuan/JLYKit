//
//  UIImage+HEIC.m
//  AFNetworking
//
//  Created by 袁宁 on 2018/7/26.
//

#import "UIImage+HEIC.h"
#import <AVFoundation/AVMediaFormat.h>

#define SIMULATE_HEIC_UNAVAILABLE 0

NSData *_Nullable jly_UIImageHEICRepresentation(UIImage *const image, const CGFloat compressionQuality)
{
    NSData *imageData = nil;
#if !SIMULATE_HEIC_UNAVAILABLE
    if (@available(iOS 11.0, *)) {
        if (image) {
            NSMutableData *destinationData = [NSMutableData new];
            CGImageDestinationRef destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)destinationData, (__bridge CFStringRef)AVFileTypeHEIC, 1, NULL);
            if (destination) {
                NSDictionary *options = @{(__bridge NSString *)kCGImageDestinationLossyCompressionQuality: @(compressionQuality)};
                CGImageDestinationAddImage(destination, image.CGImage, (__bridge CFDictionaryRef)options);
                CGImageDestinationFinalize(destination);
                imageData = destinationData;
                CFRelease(destination);
            }
        }
    }
#endif
    return imageData;
}

@implementation UIGraphicsImageRenderer (TJHEICAdditions)

- (nullable NSData *)jly_HEICDataWithCompressionQuality:(const CGFloat)compressionQuality
                                               actions:(NS_NOESCAPE UIGraphicsImageDrawingActions)actions
{
    return [self jly_HEICDataWithCompressionQuality:compressionQuality
                                           actions:actions
                                          fallback:nil];
}

- (nullable NSData *)jly_HEICDataWithCompressionQuality:(const CGFloat)compressionQuality
           fallingBackToJPEGDataWithCompressionQuality:(const CGFloat)jpegCompressionQuality
                                               actions:(NS_NOESCAPE UIGraphicsImageDrawingActions)actions
{
    return [self jly_HEICDataWithCompressionQuality:compressionQuality
                                           actions:actions
                                          fallback:^NSData *(UIImage *image) {
                                              return UIImageJPEGRepresentation(image, jpegCompressionQuality);
                                          }];
}

- (nullable NSData *)jly_HEICDataFallingBackToPNGDataWithCompressionQuality:(const CGFloat)compressionQuality
                                                                   actions:(NS_NOESCAPE UIGraphicsImageDrawingActions)actions
{
    return [self jly_HEICDataWithCompressionQuality:compressionQuality
                                           actions:actions
                                          fallback:^NSData *(UIImage *image) {
                                              return UIImagePNGRepresentation(image);
                                          }];
}

- (nullable NSData *)jly_HEICDataWithCompressionQuality:(const CGFloat)compressionQuality
                                               actions:(NS_NOESCAPE UIGraphicsImageDrawingActions)actions
                                              fallback:(NSData *(^)(UIImage *))fallback
{
    UIImage *const image = [self imageWithActions:actions];
    NSData *data = jly_UIImageHEICRepresentation(image, compressionQuality);
    if (data.length == 0 && fallback) {
        data = fallback(image);
    }
    return data;
}

@end

@implementation UIDevice (TJHEICAdditions)

+ (BOOL)isHEICWritingSupported
{
    static BOOL isHEICSupported = NO;
#if !SIMULATE_HEIC_UNAVAILABLE
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)) {
            NSMutableData *data = [NSMutableData data];
            CGImageDestinationRef destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)data, (__bridge CFStringRef)AVFileTypeHEIC, 1, nil);
            if (destination) {
                isHEICSupported = YES;
                CFRelease(destination);
            }
        }
    });
#endif
    return isHEICSupported;
}

@end

BOOL jly_CGImageSourceUTIIsHEIC(const CGImageSourceRef imageSource)
{
    BOOL isHEIC = NO;
    if (@available(iOS 11.0, *)) {
        if (imageSource) {
            NSString *const uti = (__bridge_transfer NSString *)CGImageSourceGetType(imageSource);
            isHEIC = [uti isEqualToString:AVFileTypeHEIC];
        }
    }
    return isHEIC;
}

BOOL jly_isImageAtPathHEIC(NSString *const path)
{
    BOOL isHEIC = NO;
    const CGImageSourceRef imageSource = CGImageSourceCreateWithURL((__bridge CFURLRef)[NSURL fileURLWithPath:path], nil);
    if (imageSource) {
        isHEIC = jly_CGImageSourceUTIIsHEIC(imageSource);
        CFRelease(imageSource);
    }
    return isHEIC;
}

