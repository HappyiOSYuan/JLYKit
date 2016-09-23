//
//  UIButton+center.m
//  MinderEduManager
//
//  Created by TJBT on 16/6/20.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "UIButton+center.h"

@implementation UIButton (center)

- (void)jly_centerImageAndTitle:(float)spacing{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0f, 0.0f, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0f, - imageSize.width, - (totalHeight - titleSize.height), 0.0f);
}

- (void)jly_centerImageAndTitle{
    const int spacing = 6.0f;
    [self jly_centerImageAndTitle:spacing];
}

@end
