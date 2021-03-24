//
//  JLYPopMenuModel.h
//  GenericFramework
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLYPopMenuModel : NSObject

@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,copy) NSString *itemName;

+ (instancetype)MenuModelWithDict:(NSDictionary<NSString * ,id> *)dict;

@end
