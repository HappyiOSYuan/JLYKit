//
//  JLYBaseViewController.h
//  BaseViewController
//
//  Created by mac on 16/3/14.
//  Copyright © 2016年 ningyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "viewControllerConfig.h"
#import "UIViewController+JLYVIPER.h"
#import "UIView+Additions.h"

NS_ASSUME_NONNULL_BEGIN
/**
 *  网络变化呈现的UI 可自定义
 */
@interface JLYNetWorkChangeView: UIButton

@end

/**
 * 屏幕适配的两种方法
 */
typedef NS_ENUM(NSUInteger, FitViewType){
    FitViewTypeDefault = 0,
    FitViewTypeEdgesExtended
};


@interface JLYBaseViewController : UIViewController<UITextFieldDelegate>

/**全屏布局视图开始的Y值*/
@property (nonatomic, assign, readonly) CGFloat viewToTop;
/**全局布局视图结束的Y值*/
@property (nonatomic, assign, readonly) CGFloat viewToBottom;
/**哪种适配方式,子类重写,默认是第一种*/
@property (nonatomic, assign) FitViewType  fitViewType;
/**标示当前有没有网络,每次请求接口时都要判断当期网络是否可用*/
/**只有开启了网络监听此变量才有效*/
@property (nonatomic, assign, readonly) BOOL netIsUse;
/**
 是否开启推送
 */
@property (nonatomic, assign) BOOL isOpenNotification;
/**适配条件 留个接口子类继承重写*/
- (void)fitCondition;//填充适配的条件eg:导航条是否隐藏,导航条是否透明 tabBar是否隐藏

/*!
 *  @brief 是否监听网络变化
 */
@property (nonatomic, assign) BOOL isOpenNetListen;

- (void)reachabilityChanged:(NSNotification *)note;
- (void)goNetNotUse:(UIButton*)sender;

/**
 显示加载动画

 @param view 需要显示的视图
 */
- (void)showLoadingUIWith:(UIView *)view;
/**
 显示加载动画

 @param view 需要显示的列表
 @param identifers cell标识
 */
- (void)showLoadingUIWith:(UIView *)view andCellIdentifers:(NSArray *)identifers;
/*!
 *  @brief 隐藏加载动画
 */
- (void)hideLoadingUIWith:(UIView *)view;
- (void)showLoadingUI;
- (void)hideLoadingUI;
/*!
 *  @brief 加载子视图
 */
- (void)configSubviews;
/*!
 *  @brief 布局
 */
- (void)configConstraints;
/*!
 *  @brief 初始化一些数据
 */
- (void)initializeData;
- (void)textResignFirstResponder;
/*!
 *  @brief 清空文本
 */
- (void)clearText;
- (void)xgNotification:(id)notification;

@end
NS_ASSUME_NONNULL_END
