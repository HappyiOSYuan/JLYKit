//
//  JLYPopMenuModel.m
//  GenericFramework
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYPopMenuModel.h"

@implementation JLYPopMenuModel

- (instancetype)initWithDict:(NSDictionary<NSString * ,id> *)dict{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)MenuModelWithDict:(NSDictionary<NSString * ,id> *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
