//
//  JLYDataSourceSection.h
//  Pods
//
//  Created by mac on 16/9/20.
//
//

#import <Foundation/Foundation.h>
#import "JLYTableViewDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface JLYDataSourceSection : NSObject

@property (nonatomic, strong ,nullable) NSArray * dataList;
@property(nonatomic, strong) NSArray * actions;
@property (nonatomic, strong) Class cellClazz;
@property (nonatomic, strong) NSString * identifier;
@property (nonatomic, copy) CellConfigBlock cellConfig;
@property (nonatomic, copy ,nullable) CellEventBlock cellEvent;
@property (nonatomic, strong ,nullable) NSString * headerTitle;
@property (nonatomic, strong ,nullable) NSString * footerTitle;
@property (nonatomic, strong ,nullable) UIView * headerView;
@property (nonatomic, strong ,nullable) UIView * footerView;
@property (nonatomic, assign) BOOL isAutoHeight;
@property (nonatomic, assign) CGFloat staticHeight;

@end
NS_ASSUME_NONNULL_END
