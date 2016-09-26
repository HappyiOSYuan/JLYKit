//
//  UINavigationController+JLYStackManager.h
//  Pods
//
//  Created by mac on 16/9/19.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UINavigationController (JLYStackManager)
/*!
 *  @brief 寻找UINavigationController的某一个controller
 *
 *  @param className controller的名字
 *
 *  @return controller对象
 */
- (id)jly_findViewController:(NSString *)className;
/*!
 *  @brief UINavigationController的跟控制器
 *
 *  @return 跟控制器
 */
- (UIViewController *)jly_rootViewController;
/*!
 *  @brief 返回指定的controller
 *
 *  @param className controller的类名
 *  @param animated  是否有动画
 *
 *  @return pop之后的controllers
 */
- (NSArray<id> *)jly_popToViewControllerWithClassName:(NSString *)className animated:(BOOL)animated;

@end
NS_ASSUME_NONNULL_END