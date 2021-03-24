//
//  JLYDottedLineLayer.m
//  JLYTextFeild
//
//  Created by TJBT on 16/6/2.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYDottedLineLayer.h"

@implementation JLYDottedLineLayer

- (instancetype)init{
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    self.backgroundColor = [UIColor clearColor].CGColor;
    self.strokeStart = 0.0f;
    self.lineWidth = 1.0f;
    self.lineJoin = kCALineJoinMiter;
    self.lineDashPattern = @[@2,@2];
}

- (void)updateDottedLayerPathWthHeight:(CGFloat)height{
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, self.frame.size.height - height)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    self.path = path.CGPath;
}

@end
