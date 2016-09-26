//
//  JLYTableViewDataSourceMaker.h
//  Pods
//
//  Created by mac on 16/9/20.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class JLYTableViewSectionMaker;
@interface JLYTableViewDataSourceMaker : NSObject

- (void)makeSection:(void (^)(JLYTableViewSectionMaker * section))block;

@property (nonatomic, weak) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * sections;

- (instancetype)initWithTableView:(UITableView *)tableView;
- (JLYTableViewDataSourceMaker * (^)(CGFloat))height;
- (JLYTableViewDataSourceMaker * (^)(UIView * (^)()))headerView;
- (JLYTableViewDataSourceMaker * (^)(UIView * (^)()))footerView;

- (void)commitEditing:(void(^)(UITableView *tableView, UITableViewCellEditingStyle *editingStyle, NSIndexPath *indexPath))block;
- (void)scrollViewDidScroll:(void(^)(UIScrollView *scrollView))block;

@property(nonatomic, copy ,nullable) void(^commitEditingBlock)(UITableView *tableView,UITableViewCellEditingStyle *editingStyle,NSIndexPath *indexPath);
@property(nonatomic, copy ,nullable) void(^scrollViewDidScrollBlock)(UIScrollView *scrollView);

@end
NS_ASSUME_NONNULL_END