//
//  UIViewController+JLYAdditions.h
//  iShopManageMent
//
//  Created by TJBT on 15/9/25.
//  Copyright © 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import "JDStatusBarNotification.h"

NS_ASSUME_NONNULL_BEGIN
@protocol BackButtonHandlerProtocol <NSObject>
@optional

-(BOOL)navigationShouldPopOnBackButton;

@end

@interface UIViewController (JLYAdditions)<BackButtonHandlerProtocol ,UINavigationBarDelegate>
/*!
 *  @brief  页面间传递参数
 *
 *  @since 1.1
 */
@property (nonatomic, copy) NSDictionary *passParams;

@property (nonatomic ,copy) NSNumber *isLoading;

@property (nonatomic ,strong) NSMutableArray *listDatasource;

- (void)showHud:(NSString * _Nullable)title;
- (void)dismissHud;
- (void)showErrorHud:(NSString * _Nullable)errorInfo;
- (void)showMessageSuccess:(NSString * _Nullable)messege andInfo:(NSString * _Nullable)info;
- (void)showMessageWarning:(NSString * _Nullable)messege andInfo:(NSString * _Nullable)info;
- (void)showMessageFailed:(NSString * _Nullable)messege andInfo:(NSString * _Nullable)info;

@end
NS_ASSUME_NONNULL_END