//
//  JLYPopMenuView.h
//  GenericFramework
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ItemsClickBlock)(NSString *str, NSInteger tag);
typedef void(^BackViewTapBlock)();

@interface JLYPopMenuView : UIView

@property (nonatomic,copy) ItemsClickBlock itemsClickBlock;
@property (nonatomic,copy) BackViewTapBlock backViewTapBlock;

/**
 *  menu
 *
 *  @param frame            菜单frame
 *  @param target           将在在何控制器弹出
 *  @param dataArray        菜单项内容
 *  @param itemsClickBlock  点击某个菜单项的blick
 *  @param backViewTapBlock 点击背景遮罩的block
 *
 *  @return 返回创建对象
 */
+ (instancetype)createMenuWithFrame:(CGRect)frame
                           target:(UIViewController *)target
                        dataArray:(NSArray *)dataArray
                  itemsClickBlock:(void(^)(NSString *str, NSInteger tag))itemsClickBlock
                      backViewTap:(void(^)())backViewTapBlock;
/**
 *  展示菜单
 *
 *  @param isShow YES:展示  NO:隐藏
 */
- (void)showMenuWithAnimation:(BOOL)isShow;
- (void)popMenu;

@end
