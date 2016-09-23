//
//  NSMutableString+JLYNetworkingMethods.m
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "NSMutableString+JLYNetworkingMethods.h"
#import "NSObject+JLYNetworkingMethods.h"

@implementation NSMutableString (JLYNetworkingMethods)

- (void)jly_appendURLRequest:(NSURLRequest *)request{
    [self appendFormat:@"\n\nHTTP URL:\n\t%@", request.URL];
    [self appendFormat:@"\n\nHTTP Header:\n%@", request.allHTTPHeaderFields ? request.allHTTPHeaderFields : @"\t\t\t\t\tN/A"];
    [self appendFormat:@"\n\nHTTP Body:\n\t%@", [[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding] jly_defaultValue:@"\t\t\t\tN/A"]];
}

@end
