//
//  NDBMethodSwizzling.h
//  iShopManageMent
//
//  Created by TJBT on 15/12/14.
//  Copyright © 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLYMethodSwizzling : NSObject

void SwizzlingMethod(Class c, SEL origSEL, SEL newSEL);

@end
