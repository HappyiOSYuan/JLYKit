//
//  JLYTableViewSectionMaker.h
//  Pods
//
//  Created by mac on 16/9/20.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class JLYDataSourceSection;
@interface JLYTableViewSectionMaker : NSObject

- (JLYTableViewSectionMaker * (^)(Class))cellClazz;

- (JLYTableViewSectionMaker * (^)(NSArray * _Nullable))dataList;

- (JLYTableViewSectionMaker * (^)(NSArray *))actions;

- (JLYTableViewSectionMaker * (^)(void(^)(__kindof UITableViewCell *cell, id model, NSIndexPath *indexPath)))cellConfig;

- (JLYTableViewSectionMaker * (^)(CGFloat))height;

- (JLYTableViewSectionMaker * (^)(void))autoHeight;

- (JLYTableViewSectionMaker * (^)(void(^)(NSIndexPath *indexPath, id model)))cellEvent;

- (JLYTableViewSectionMaker * (^)(NSString * _Nullable))headerTitle;
- (JLYTableViewSectionMaker * (^)(NSString * _Nullable))footerTitle;

- (JLYTableViewSectionMaker * (^)(__kindof UITableViewHeaderFooterView * _Nullable (^)(void)))headerView;
- (JLYTableViewSectionMaker * (^)(__kindof UITableViewHeaderFooterView * _Nullable (^)(void)))footerView;

@property(nonatomic, strong) JLYDataSourceSection * section;

@end
NS_ASSUME_NONNULL_END
