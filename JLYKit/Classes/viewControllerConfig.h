//
//  viewControllerConfig.h
//  JLYBaseViewController
//
//  Created by TJBT on 16/3/15.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#ifndef viewControllerConfig_h
#define viewControllerConfig_h

#import <JDStatusBarNotification/JDStatusBarNotification.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "UIViewController+JLYAdditions.h"
#import "UIScrollView+EmptyDataSet.h"
#import "JLYAppUtils.h"
#import <MLInputDodger/UIView+MLInputDodger.h>
#import "JLYAlertController.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>
#import <SDAutoLayout/UITableView+SDAutoTableViewCellHeight.h>
#import <MJRefresh/MJRefresh.h>
#import "UINavigationBar+Awesome.h"
#import "JLYMaterialTextFeild.h"
#import "JLYMaterialTextView.h"
#import "JLYBaseVCModuleProtocol.h"
#import "UIControl+JLYFixMultiClick.h"

#define WeakObj(o) autoreleasepool{} __weak typeof(o) Weak##o = o;
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = Weak##o;

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define themeColor RGBA(54.0f, 182.0f, 169.0f, 1.0f)
#define backColor RGBA(246.0f, 246.0f, 246.0f, 1.0f)
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define font(x) [UIFont systemFontOfSize:x]

typedef void (^NextViewControllerBlock)(id obj);

#endif /* viewControllerConfig_h */
