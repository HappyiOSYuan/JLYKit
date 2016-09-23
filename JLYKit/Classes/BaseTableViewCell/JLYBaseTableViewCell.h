//
//  JLYBaseTableViewCell.h
//  JLYBaseViewController
//
//  Created by TJBT on 16/3/15.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "viewControllerConfig.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^BaseTableViewCellBlock)(id _Nonnull obj);

@interface JLYBaseTableViewCell : UITableViewCell

@property (nonatomic, copy ,nonnull) BaseTableViewCellBlock cellBlock;
/*!
 *  @brief 数据源
 */
@property (nonatomic ,copy) id model;

- (void)handlerButtonAction:(nonnull BaseTableViewCellBlock)block;
/*!
 *  @brief 加载子视图
 */
- (void)configSubviews;
/*!
 *  @brief 布局
 */
- (void)configConstraints;

@end
NS_ASSUME_NONNULL_END