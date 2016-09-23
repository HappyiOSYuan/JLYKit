//
//  JLYBaseNavigationController.h
//  Pods
//
//  Created by mac on 16/9/14.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UINavigationController (JLYNavSafeTransition)

@property(nonatomic, assign, getter = isTransitionInProgress) BOOL transitionInProgress;

@end

@interface JLYBaseNavigationController : UINavigationController

@end
NS_ASSUME_NONNULL_END