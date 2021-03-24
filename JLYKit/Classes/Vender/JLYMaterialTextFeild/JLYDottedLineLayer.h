//
//  JLYDottedLineLayer.h
//  JLYTextFeild
//
//  Created by TJBT on 16/6/2.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface JLYDottedLineLayer : CAShapeLayer

- (void)updateDottedLayerPathWthHeight:(CGFloat)height;

@end
NS_ASSUME_NONNULL_END