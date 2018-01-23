//
//  JLYBaseTableViewDataSource.h
//  Pods
//
//  Created by mac on 16/9/20.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^CellConfigBlock)(UITableViewCell *cell, id model, NSIndexPath *indexPath);
typedef void (^CellEventBlock)(NSIndexPath *indexPath, id model);

@class JLYDataSourceSection;
@protocol JLYBaseTableViewDataSourceProtocol<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray<JLYDataSourceSection *>*sections;
@property (nonatomic, strong) NSMutableDictionary<NSString * ,id> *delegates;

@end

@class JLYDataSourceSection;
@interface JLYBaseTableViewDataSource : NSObject<JLYBaseTableViewDataSourceProtocol>

@property (nonatomic, strong) NSMutableArray<JLYDataSourceSection *>*sections;

@end
NS_ASSUME_NONNULL_END
