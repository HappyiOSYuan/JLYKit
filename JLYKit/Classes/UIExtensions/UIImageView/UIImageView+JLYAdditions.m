//
//  UIImageView+JLYAdditions.m
//  Pods
//
//  Created by mac on 16/9/19.
//
//

#import "UIImageView+JLYAdditions.h"

@implementation UIImageView (JLYAdditions)

+ (id)jly_imageViewWithImageNamed:(NSString*)imageName{
    NSAssert(imageName != nil, @"图片名字不能为空");
    NSAssert([UIImage imageNamed:imageName] != nil, @"图片不存在");
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
}

+ (id)jly_imageViewWithImageArray:(NSArray<NSString *> *)imageArray duration:(NSTimeInterval)duration;{
    
    if (imageArray && [imageArray count] <= 0){
        return nil;
    }
    UIImageView *imageView = [UIImageView jly_imageViewWithImageNamed:[imageArray objectAtIndex:0]];
    NSMutableArray *images = [NSMutableArray array];
    [imageArray enumerateObjectsUsingBlock:^(NSString *imageName ,NSUInteger idx ,BOOL *stop){
        [images addObject:[UIImage imageNamed:imageName]];
    }];
    [imageView setImage:images[0]];
    [imageView setAnimationImages:images];
    [imageView setAnimationDuration:duration];
    [imageView setAnimationRepeatCount:0];
    return imageView;
}

@end
