//
//  JLYLoadingShimmer.h
//  AFNetworking
//
//  Created by 袁宁 on 2018/12/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JLYLoadingShimmer : NSObject

/* 开始覆盖子控件 */
+ (void)jly_startCovering:(UIView *)view;
/** 停止覆盖子控件 */
+ (void)jly_stopCovering:(UIView *)view;
+ (void)jly_startCovering:(UIView *)view andIdentifers:(NSArray *)identifers;

@end

NS_ASSUME_NONNULL_END
