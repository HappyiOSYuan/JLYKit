//
//  JLYBaseTableViewHeaderFooterView.m
//  PayTreasure2.0
//
//  Created by mac on 16/3/21.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYBaseTableViewHeaderFooterView.h"

@implementation JLYBaseTableViewHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self configSubviews];
        [self configConstraints];
    }
    return self;
}

- (void)configSubviews{
    
}

- (void)configConstraints{
    
}

- (void)configHeaderFooterWithEntity:(id)entity{
    NSAssert(entity != nil, @"entity should not be nil!!!");
}

@end
