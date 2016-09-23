//
//  NSString+Path.m
//  iOrder
//
//  Created by TJBT on 15/12/21.
//  Copyright © 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "NSObject+Path.h"

@implementation NSObject (Path)

- (NSString *)getPath{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *directryPath = [documentDirectory stringByAppendingPathComponent:@"MyPhotos"];
    [fileManager createDirectoryAtPath:directryPath withIntermediateDirectories:YES attributes:nil error:nil];
    return directryPath;
}

- (NSString *)imageName{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"yyyyMMdd_HHmmss"];//设置系统时间格式
    NSString *imageName =[NSString stringWithFormat:@"IMG_%@", [[formatter stringFromDate:date] stringByAppendingPathExtension:@"png"]];
    return imageName;
}

- (NSString *)imageFullPath{
    return [[self getPath] stringByAppendingPathComponent:[self imageName]];
}

@end
