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

- (JLYTableViewSectionMaker * (^)(void(^)(id cell, id model, NSIndexPath *indexPath)))cellConfig;

- (JLYTableViewSectionMaker * (^)(CGFloat))height;

- (JLYTableViewSectionMaker * (^)())autoHeight;

- (JLYTableViewSectionMaker * (^)(void(^)(NSIndexPath *indexPath, id model)))cellEvent;

- (JLYTableViewSectionMaker * (^)(NSString * _Nullable))headerTitle;
- (JLYTableViewSectionMaker * (^)(NSString * _Nullable))footerTitle;

- (JLYTableViewSectionMaker * (^)(UIView * (^)()))headerView;
- (JLYTableViewSectionMaker * (^)(UIView * (^)()))footerView;

@property(nonatomic, strong) JLYDataSourceSection * section;

@end
NS_ASSUME_NONNULL_END