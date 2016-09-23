//
//  UIImage+JLYLaunchImage.m
//  JLYLaunchAnimationDemo
//
//  Created by ningyuan on 15/12/3.
//  Copyright © 2015年 ningyuan. All rights reserved.
//

#import "UIImage+JLYLaunchImage.h"

//current window
#define tyCurrentWindow [[UIApplication sharedApplication].windows firstObject]

@implementation UIImage (JLYLaunchImage)

// 引用自stackflow
+ (NSString *)jly_getLaunchImageName{
    NSString *viewOrientation = @"Portrait";
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        viewOrientation = @"Landscape";
    }
    __block NSString *launchImageName = nil;
    NSArray<NSDictionary <NSString * ,id>*>* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    CGSize viewSize = tyCurrentWindow.bounds.size;
    [imagesDict enumerateObjectsUsingBlock:^(NSDictionary* dict ,NSUInteger idx ,BOOL *stop){
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]){
            launchImageName = dict[@"UILaunchImageName"];
        }

    }];
    return launchImageName;
}

+ (UIImage *)jly_getLaunchImage{
    return [UIImage imageNamed:[self jly_getLaunchImageName]];
}

@end
