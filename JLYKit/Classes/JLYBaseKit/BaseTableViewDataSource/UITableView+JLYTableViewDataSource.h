//
//  UITableView+JLYTableViewDataSource.h
//  Pods
//
//  Created by mac on 16/9/20.
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class JLYBaseTableViewDataSource;
@class JLYTableViewDataSourceMaker;
@interface UITableView (JLYTableViewDataSource)

@property(nonatomic, strong) JLYBaseTableViewDataSource * jlyTableViewDataSource;

- (void)jly_makeDataSource:(void (^)(JLYTableViewDataSourceMaker *make))maker;
- (void)jly_makeSectionWithData:(NSArray *)dataList;
- (void)jly_makeSectionWithData:(NSArray *)dataList andCellClass:(Class)cellClass;

@end

__attribute__((unused)) static void commitEditing(id self, SEL cmd ,__kindof UITableView *tableView ,UITableViewCellEditingStyle editingStyle ,NSIndexPath *indexPath);

__attribute__((unused)) static void scrollViewDidScroll(id self, SEL cmd, UIScrollView *scrollView);
NS_ASSUME_NONNULL_END