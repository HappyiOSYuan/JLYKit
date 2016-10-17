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
typedef void (^BaseTableViewCellBlock)(id obj);

@interface JLYBaseTableViewCell : UITableViewCell

@property (nonatomic, copy) BaseTableViewCellBlock cellBlock;
/*!
 *  @brief 数据源
 */
@property (nonatomic, copy) id model;

@property (nonatomic ,strong) NSIndexPath *indexPath;

- (void)handlerButtonAction:(BaseTableViewCellBlock)block;
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