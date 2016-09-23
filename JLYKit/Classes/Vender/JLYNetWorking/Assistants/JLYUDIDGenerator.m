//
//  NDBUDIDGenerator.m
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYUDIDGenerator.h"
#import "JLYNetworkingConfiguration.h"

@implementation JLYUDIDGenerator
static JLYUDIDGenerator * instance = nil;

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

- (NSString *)UDID{
    NSData *udidData = [self searchKeychainCopyMatching:JLYUDIDName];
    NSString *udid = nil;
    if (udidData != nil) {
        NSString *temp = [[NSString alloc] initWithData:udidData encoding:NSUTF8StringEncoding];
        udid = [NSString stringWithFormat:@"%@", temp];
    }
    if (udid.length == 0) {
        udid = [self readPasteBoradforIdentifier:JLYUDIDName];
    }
    return udid;
}

- (void)saveUDID:(NSString *)udid{
    BOOL saveOk = NO;
    NSData *udidData = [self searchKeychainCopyMatching:JLYUDIDName];
    if (udidData == nil) {
        saveOk = [self createKeychainValue:udid forIdentifier:JLYUDIDName];
    }else{
        saveOk = [self updateKeychainValue:udid forIdentifier:JLYUDIDName];
    }
    if (!saveOk) {
        [self createPasteBoradValue:udid forIdentifier:JLYUDIDName];
    }
}

- (NSMutableDictionary *)newSearchDictionary:(NSString *)identifier{
    NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc] init];
    
    [searchDictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    
    NSData *encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrGeneric];
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrAccount];
    [searchDictionary setObject:JLYKeychainServiceName forKey:(__bridge id)kSecAttrService];
    
    return searchDictionary;
}

- (NSData *)searchKeychainCopyMatching:(NSString *)identifier{
    NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifier];
    
    // Add search attributes
    [searchDictionary setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    
    // Add search return types
    [searchDictionary setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    
    CFDataRef result = nil;
    SecItemCopyMatching((__bridge CFDictionaryRef)searchDictionary,
                        (CFTypeRef *)&result);
    
    return (__bridge NSData *)result;
}

- (BOOL)createKeychainValue:(NSString *)value forIdentifier:(NSString *)identifier{
    NSMutableDictionary *dictionary = [self newSearchDictionary:identifier];
    
    NSData *passwordData = [value dataUsingEncoding:NSUTF8StringEncoding];
    [dictionary setObject:passwordData forKey:(__bridge id)kSecValueData];
    
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)dictionary, NULL);
    
    if (status == errSecSuccess) {
        return YES;
    }
    return NO;
}

- (BOOL)updateKeychainValue:(NSString *)value forIdentifier:(NSString *)identifier{
    NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifier];
    NSMutableDictionary *updateDictionary = [[NSMutableDictionary alloc] init];
    NSData *passwordData = [value dataUsingEncoding:NSUTF8StringEncoding];
    [updateDictionary setObject:passwordData forKey:(__bridge id)kSecValueData];
    
    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)searchDictionary,
                                    (__bridge CFDictionaryRef)updateDictionary);
    if (status == errSecSuccess) {
        return YES;
    }
    return NO;
}

- (void)deleteKeychainValue:(NSString *)identifier{
    NSMutableDictionary *searchDictionary = [self newSearchDictionary:identifier];
    SecItemDelete((__bridge CFDictionaryRef)searchDictionary);
}

- (void)createPasteBoradValue:(NSString *)value forIdentifier:(NSString *)identifier{
    UIPasteboard *pb = [UIPasteboard pasteboardWithName:JLYKeychainServiceName create:YES];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:value forKey:identifier];
    NSData *dictData = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [pb setData:dictData forPasteboardType:JLYPasteboardType];
}

- (NSString *)readPasteBoradforIdentifier:(NSString *)identifier{
    UIPasteboard *pb = [UIPasteboard pasteboardWithName:JLYKeychainServiceName create:YES];
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:[pb dataForPasteboardType:JLYPasteboardType]];
    return [dict objectForKey:identifier];
}


@end
