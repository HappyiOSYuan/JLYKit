//
//  JLYForm.h
//  GenericFramework
//
//  Created by mac on 16/7/22.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface JLYForm : UIView

@property (nonatomic, strong ,readonly) NSArray<NSNumber *> *columnsWidths;
@property (nonatomic, assign ,readonly) uint numRows;
@property (nonatomic, assign ,readonly) uint dy;

- (id)initWithFrame:(CGRect)frame andColumnsWidths:(__kindof NSArray<NSNumber *>*)columns;
- (void)addRecord:(__kindof NSArray<NSString *>*)record;
- (void)reloadData;

@end
NS_ASSUME_NONNULL_END