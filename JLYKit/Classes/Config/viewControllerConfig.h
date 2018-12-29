//
//  viewControllerConfig.h
//  JLYBaseViewController
//
//  Created by TJBT on 16/3/15.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#ifndef viewControllerConfig_h
#define viewControllerConfig_h

#import <SVProgressHUD/SVProgressHUD.h>
#import "UIViewController+JLYAdditions.h"
#import "UIScrollView+EmptyDataSet.h"
#import "JLYAppUtils.h"
#import <MLInputDodger/UIView+MLInputDodger.h>
#import "JLYAlertController.h"
#import <SDAutoLayout/UIView+SDAutoLayout.h>
#import <SDAutoLayout/UITableView+SDAutoTableViewCellHeight.h>
#import "UINavigationBar+Awesome.h"
#import "JLYMaterialTextFeild.h"
#import "JLYMaterialTextView.h"
#import "JLYBaseVCModuleProtocol.h"
#import "UIControl+JLYFixMultiClick.h"
#import "JLYLoadingShimmer.h"
#import <libextobjc/extobjc.h>

#define SUPPRESS_UNDECLARED_SELECTOR_LEAK_WARNING(customCode)                        \
_Pragma("clang diagnostic push")                                        \
_Pragma("clang diagnostic ignored \"-Wundeclared-selector\"")     \
customCode;                                                                   \
_Pragma("clang diagnostic pop")

#define SUPPRESS_PERFORM_SELECTOR_LEAKWARNING(customCode) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
customCode; \
_Pragma("clang diagnostic pop") \
} while (0)

static inline UIEdgeInsets jly_safeAreaInset(UIView *view) {
    if (@available(iOS 11.0, *)) {
        return view.safeAreaInsets;
    }
    return UIEdgeInsetsMake(64.0f, 0.0f, 0.0f, 0.0f);
}

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define themeColor(customColor) customColor ? : defaultTheme
#define defaultTheme RGBA(54.0f, 182.0f, 169.0f, 1.0f)

#define backColor(customColor) customColor ? : defaultBack
#define defaultBack RGBA(246.0f, 246.0f, 246.0f, 1.0f)

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define SafeAreaTopHeight (screenHeight == 812.0 ? 88.0f : 64.0f)
#define SafeAreaBottomHeight (screenHeight == 812.0 ? 34.0f : 0.0f)

#define font(x) [UIFont systemFontOfSize:x]
#define Numfont(x) [UIFont fontWithName:@"AppleGothic" size:x]

typedef void (^NextViewControllerBlock)(id obj);

#endif /* viewControllerConfig_h */
