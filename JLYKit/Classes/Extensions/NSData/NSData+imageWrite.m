//
//  NSData+imageWrite.m
//  iShopManageMent
//
//  Created by TJBT on 15/12/21.
//  Copyright © 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "NSData+imageWrite.h"

@implementation NSData (imageWrite)

- (void)imageWriteToFile{
    [self writeToFile:[self imageFullPath] atomically:NO];
}

@end
