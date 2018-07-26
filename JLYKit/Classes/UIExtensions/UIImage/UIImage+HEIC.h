//
//  UIImage+HEIC.h
//  AFNetworking
//
//  Created by 袁宁 on 2018/7/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Returns and NSData HEIC representation of the image if possible, otherwise returns nil.
NSData *_Nullable jly_UIImageHEICRepresentation(UIImage *const image, const CGFloat compressionQuality);

@interface UIGraphicsImageRenderer (TJHEICAdditions)

- (nullable NSData *)jly_HEICDataWithCompressionQuality:(const CGFloat)compressionQuality
                                               actions:(NS_NOESCAPE UIGraphicsImageDrawingActions)actions;

- (nullable NSData *)jly_HEICDataWithCompressionQuality:(const CGFloat)compressionQuality
           fallingBackToJPEGDataWithCompressionQuality:(const CGFloat)jpegCompressionQuality
                                               actions:(NS_NOESCAPE UIGraphicsImageDrawingActions)actions;

- (nullable NSData *)jly_HEICDataFallingBackToPNGDataWithCompressionQuality:(const CGFloat)compressionQuality
                                                                   actions:(NS_NOESCAPE UIGraphicsImageDrawingActions)actions;

@end

@interface UIDevice (TJHEICAdditions)

+ (BOOL)isHEICWritingSupported;

@end

BOOL jly_CGImageSourceUTIIsHEIC(const CGImageSourceRef imageSource);
BOOL jly_isImageAtPathHEIC(NSString *const path);

NS_ASSUME_NONNULL_END
