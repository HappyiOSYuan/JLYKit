//
//  JLYBaseTableViewHeaderFooterView.h
//  PayTreasure2.0
//
//  Created by mac on 16/3/21.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "viewControllerConfig.h"

NS_ASSUME_NONNULL_BEGIN
@interface JLYBaseTableViewHeaderFooterView : UITableViewHeaderFooterView

- (void)configSubviews;
- (void)configConstraints;
- (void)configHeaderFooterWithEntity:(id)entity;

@end
NS_ASSUME_NONNULL_END