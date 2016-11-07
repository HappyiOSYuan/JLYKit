//
//  JLYBaseTableViewController.h
//  BaseViewController
//
//  Created by mac on 16/3/14.
//  Copyright © 2016年 ningyuan. All rights reserved.
//

#import "JLYBaseViewController.h"
#import "JLYTableViewDataSource.h"
#import <MJRefresh/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN
@interface JLYBaseTableViewController : JLYBaseViewController

@property (nonatomic, strong, readonly) UITableView *tableView;
/*!
 *  @brief 数据源
 *
 *  @since 1.0
 */
@property (nonatomic, strong) NSMutableArray *dataArray;
//*****************是否开启头部刷新和脚部刷新 子类可在ViewDidLoad方法设置开启与否 默认都不开启******************************//
/*!
 *  @brief 开启头部刷新
 *
 *  @since 1.0
 */
@property (nonatomic, assign)   BOOL isOpenHeaderRefresh;
/*!
 *  @brief 开启加载更多
 */
@property (nonatomic, assign)   BOOL isOpenFooterRefresh;

//*****************只有开启头部刷新和脚部刷新 下面的方法才被回调子类重写***********************//
/*!
 *  @brief 头部刷新的回调子类重写
 *
 *  @since 1.0
 */
- (void)headerRefresh;
/*!
 *  @brief 脚部刷新的回调子类重写
 *
 *  @since 1.0
 */
- (void)footerRefresh;

@end
NS_ASSUME_NONNULL_END
