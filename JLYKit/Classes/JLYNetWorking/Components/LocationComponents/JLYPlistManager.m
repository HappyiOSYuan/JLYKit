//
//  NDBPlistManager.m
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYPlistManager.h"

@interface JLYPlistManager ()

@property (nonatomic, strong, readwrite) NSString *fileName;
@property (nonatomic, readwrite) BOOL isBundle;

@end

@implementation JLYPlistManager
#pragma mark - life cycle
- (id)initWithFileName:(NSString *)fileName isBundle:(BOOL)isBundle{
    self = [super init];
    if (self) {
        self.fileName = fileName;
        self.isBundle = isBundle;
        
        NSString *errorDesc = nil;
        NSString *plistPath = nil;
        
        if (isBundle) {
            plistPath = [[NSBundle mainBundle] pathForResource:self.fileName ofType:@"plist"];
        } else {
            plistPath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", self.fileName]];
        }
        
        NSPropertyListFormat format;
        NSData *plistData = [[NSFileManager defaultManager] contentsAtPath:plistPath];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
        self.listData = [NSPropertyListSerialization dataWithPropertyList:plistData
                                                                       format:NSPropertyListXMLFormat_v1_0
                                                                      options:NSPropertyListMutableContainersAndLeaves
                                                                        error:&errorDesc];
#else
        self.listData = [NSPropertyListSerialization dataFromPropertyList:plistData
                                                                       format:NSPropertyListXMLFormat_v1_0
                                                             errorDescription:&errorDesc];
#endif
    }
    return self;
}

- (id)initWithFileNameAutoCreate:(NSString *)fileName{
    self = [super init];
    if (self) {
        self.fileName = fileName;
        
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
        NSString *plistPath = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", self.fileName]];
        
        self.isBundle = NO; //默认从Library下读取
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
            [[NSFileManager defaultManager] createFileAtPath:plistPath contents:nil attributes:nil];
        }
        
        NSString *errorDesc = nil;
        NSPropertyListFormat format;
        NSData *plistData = [[NSFileManager defaultManager] contentsAtPath:plistPath];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
        self.listData = [NSPropertyListSerialization dataWithPropertyList:plistData
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                                  options:NSPropertyListMutableContainersAndLeaves
                                                                    error:&errorDesc];
#else
        self.listData = [NSPropertyListSerialization dataFromPropertyList:plistData
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&errorDesc];
#endif
    }
    return self;
}

- (BOOL)save{
    NSString *error = nil;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", self.fileName]];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSData *plistData = [NSPropertyListSerialization dataWithPropertyList:self.listData
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                                  options:NSPropertyListMutableContainersAndLeaves
                                                                    error:&error];
#else
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:self.listData
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&error];
#endif
    if(plistData) {
        [plistData writeToFile:plistPath atomically:YES];
        return YES;
    } else {
        NSLog(@"Error saving plist: %@", error);
        return NO;
    }
}

- (BOOL)isExistWithFileNameInLibrary:(NSString *)plistFileName{
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", plistFileName]];
    return [[NSFileManager defaultManager] fileExistsAtPath:plistPath];
}

- (BOOL)isExistWithFileNameInBundle:(NSString *)plistFileName{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistFileName ofType:@"plist"];
    return [[NSFileManager defaultManager] fileExistsAtPath:plistPath];
}

- (BOOL)saveData:(id)data withFileName:(NSString *)fileName{
    
    if (!([data isKindOfClass:[NSArray class]] || [data isKindOfClass:[NSDictionary class]])) {
        return NO;
    }
    
    if ([self isExistWithFileNameInLibrary:fileName]) {
        [self deletePlistFile:fileName];
    }
    
    NSString *error = nil;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", fileName]];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSData *plistData = [NSPropertyListSerialization dataWithPropertyList:data
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                                  options:NSPropertyListMutableContainersAndLeaves
                                                                    error:&error];
#else
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:data
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&error];
#endif
    if (plistData) {
        [[NSFileManager defaultManager] createFileAtPath:plistPath contents:nil attributes:nil];
        [plistData writeToFile:plistPath atomically:YES];
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)saveString:(NSString *)string withFileName:(NSString *)fileName{
    if ([self isExistWithFileNameInLibrary:fileName]) {
        [self deletePlistFile:fileName];
    }
    
    NSError *error = nil;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", fileName]];
    
    [string writeToFile:plistPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    return !error;
}

- (BOOL)deletePlistFile:(NSString *)fileName{
    if (![self isExistWithFileNameInLibrary:fileName]) {
        return YES;
    }
    
    NSError *error = nil;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", fileName]];
    
    if (![[NSFileManager defaultManager] removeItemAtPath:filePath error:&error]) {
        return NO;
    }
    
    return YES;
}

- (id)loadDataWithFileName:(NSString *)fileName{
    BOOL fileFounded = YES;
    
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", fileName]];
    
    //这里不使用[self isPlistFileExistWithPlistFileName:(NSString *)plistFileName]的原因是因为libraryFilePath到后面有可能要用的，所以后面就直接用NSFileManager来判断了。
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        fileFounded = NO;
    }
    
    if (fileFounded == NO) {
        filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            fileFounded = YES;
        }
    }
    
    if (fileFounded) {
        NSString *errorDesc = nil;
        NSPropertyListFormat format;
        NSData *plistData = [[NSFileManager defaultManager] contentsAtPath:filePath];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
        id result = [NSPropertyListSerialization dataWithPropertyList:plistData
                                                                       format:NSPropertyListXMLFormat_v1_0
                                                                      options:NSPropertyListMutableContainersAndLeaves
                                                                        error:&errorDesc];
#else
        id result = [NSPropertyListSerialization dataFromPropertyList:plistData
                                                                       format:NSPropertyListXMLFormat_v1_0
                                                             errorDescription:&errorDesc];
#endif
        return result;
    }
    
    return nil;
}

- (NSString *)loadStringWithFileName:(NSString *)fileName{
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", fileName]];
    NSError *error = nil;
    NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    return content;
}

@end
