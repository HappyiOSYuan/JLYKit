//
//  JLYURLRouter.m
//
//  Created by NingYuan on 15/6/16.
//  Copyright (c) 2014 TJBT. All rights reserved.
//

#import "JLYURLRouter.h"
#import <objc/runtime.h>

static NSString * const JLY_ROUTER_WILDCARD_CHARACTER = @"~";
static NSString * const specialCharacters = @"/?&.";

NSString * const JLYURLRouterParameterURL = @"JLYURLRouterParameterURL";
NSString * const JLYURLRouterParameterCompletion = @"JLYURLRouterParameterCompletion";
NSString * const JLYURLRouterParameterUserInfo = @"JLYURLRouterParameterUserInfo";


@interface JLYURLRouter ()
/**
 *  保存了所有已注册的 URL
 *  结构类似 @{@"beauty": @{@":id": {@"_", [block copy]}}}
 */
@property (nonatomic) NSMutableDictionary<NSString * ,id>*routes;

@end

@implementation JLYURLRouter

static JLYURLRouter *instance = nil;

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

+ (void)registerURLPattern:(NSString *)URLPattern withHandler:(JLYURLRouterHandler)handler{
    [[self sharedInstance] addURLPattern:URLPattern andHandler:handler];
}

+ (void)deregisterURLPattern:(NSString *)URLPattern{
    [[self sharedInstance] removeURLPattern:URLPattern];
}

+ (void)openURL:(NSString *)URL{
    [self openURL:URL completion:nil];
}

+ (void)openURL:(NSString *)URL completion:(void (^)(id result))completion{
    [self openURL:URL withUserInfo:nil completion:completion];
}

+ (void)openURL:(NSString *)URL withUserInfo:(NSDictionary<NSString * ,id>*)userInfo completion:(void (^)(id result))completion{
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *parameters = [[self sharedInstance] extractParametersFromURL:URL];
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, NSString *obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            parameters[key] = [obj stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
    }];
    
    if (parameters) {
        JLYURLRouterHandler handler = parameters[@"block"];
        if (completion) {
            parameters[JLYURLRouterParameterCompletion] = completion;
        }
        if (userInfo) {
            parameters[JLYURLRouterParameterUserInfo] = userInfo;
        }
        if (handler) {
            [parameters removeObjectForKey:@"block"];
            handler(parameters);
        }
    }
}

+ (BOOL)canOpenURL:(NSString *)URL{
    return [[self sharedInstance] extractParametersFromURL:URL] ? YES : NO;
}

+ (NSString *)generateURLWithPattern:(NSString *)pattern parameters:(NSArray<NSString *>*)parameters{
    NSInteger startIndexOfColon = 0;
    
    NSMutableArray<NSString *>*placeholders = [NSMutableArray array];
    for (int i = 0; i < pattern.length; i++) {
        @autoreleasepool {
        
            NSString *character = [NSString stringWithFormat:@"%c", [pattern characterAtIndex:i]];
            if ([character isEqualToString:@":"]) {
                startIndexOfColon = i;
            }
            if ([specialCharacters rangeOfString:character].location != NSNotFound && i > (startIndexOfColon + 1) && startIndexOfColon) {
                NSRange range = NSMakeRange(startIndexOfColon, i - startIndexOfColon);
                NSString *placeholder = [pattern substringWithRange:range];
                if (![self checkIfContainsSpecialCharacter:placeholder]) {
                    [placeholders addObject:placeholder];
                    startIndexOfColon = 0;
                }
            }
            if (i == pattern.length - 1 && startIndexOfColon) {
                NSRange range = NSMakeRange(startIndexOfColon, i - startIndexOfColon + 1);
                NSString *placeholder = [pattern substringWithRange:range];
                if (![self checkIfContainsSpecialCharacter:placeholder]) {
                    [placeholders addObject:placeholder];
                }
            }
        }
    }
    
    __block NSString *parsedResult = pattern;
    
    [placeholders enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        idx = parameters.count > idx ? idx : parameters.count - 1;
        parsedResult = [parsedResult stringByReplacingOccurrencesOfString:obj withString:parameters[idx]];
    }];
    
    return parsedResult;
}

+ (id)objectForURL:(NSString *)URL withUserInfo:(NSDictionary<NSString * ,id>*)userInfo{
    JLYURLRouter *router = [JLYURLRouter sharedInstance];
    
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary <NSString * ,id>*parameters = [router extractParametersFromURL:URL];
    JLYURLRouterObjectHandler handler = parameters[@"block"];
    
    if (handler) {
        if (userInfo) {
            parameters[JLYURLRouterParameterUserInfo] = userInfo;
        }
        [parameters removeObjectForKey:@"block"];
        return handler(parameters);
    }
    return nil;
}

+ (id)objectForURL:(NSString *)URL{
    id obj = [self objectForURL:URL withUserInfo:nil];
    NSAssert(obj != nil, @"请检查url");
    return obj;
}

+ (void)registerURLPattern:(NSString *)URLPattern withObjectHandler:(JLYURLRouterObjectHandler)handler{
    [[self sharedInstance] addURLPattern:URLPattern andObjectHandler:handler];
}

- (void)addURLPattern:(NSString *)URLPattern andHandler:(JLYURLRouterHandler)handler{
    NSMutableDictionary <NSString * ,id>*subRoutes = [self addURLPattern:URLPattern];
    if (handler && subRoutes) {
        subRoutes[@"_"] = [handler copy];
    }
}

- (void)addURLPattern:(NSString *)URLPattern andObjectHandler:(JLYURLRouterObjectHandler)handler{
    NSMutableDictionary<NSString * ,id>*subRoutes = [self addURLPattern:URLPattern];
    if (handler && subRoutes) {
        subRoutes[@"_"] = [handler copy];
    }
}

- (NSMutableDictionary<NSString * ,id>*)addURLPattern:(NSString *)URLPattern{
    NSArray <NSString *>*pathComponents = [self pathComponentsFromURL:URLPattern];
    NSInteger index = 0;
    NSMutableDictionary<NSString * ,id>*subRoutes = self.routes;
    @autoreleasepool {
        while (index < pathComponents.count) {
            NSString *pathComponent = pathComponents[index];
            if (![subRoutes objectForKey:pathComponent]) {
                subRoutes[pathComponent] = [[NSMutableDictionary alloc] init];
            }
            subRoutes = subRoutes[pathComponent];
            index++;
        }
    }
    
    return subRoutes;
}

#pragma mark - Utils

- (NSMutableDictionary<NSString * ,id>*)extractParametersFromURL:(NSString *)url{
    NSMutableDictionary<NSString * ,id>*parameters = [NSMutableDictionary dictionary];
    
    parameters[JLYURLRouterParameterURL] = url;
    
    NSMutableDictionary<NSString * ,id>*subRoutes = self.routes;
    NSArray<NSString *>*pathComponents = [self pathComponentsFromURL:url];
    
    // borrowed from HHRouter(https://github.com/Huohua/HHRouter)
    for (NSString *pathComponent in pathComponents) {
        @autoreleasepool {
            
            BOOL found = NO;
            
            // 对 key 进行排序，这样可以把 ~ 放到最后
            NSArray<NSString *>*subRoutesKeys =[subRoutes.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
                return [obj1 compare:obj2];
            }];
            
            for (NSString *key in subRoutesKeys) {
                @autoreleasepool {
                    if ([key isEqualToString:pathComponent] || [key isEqualToString:JLY_ROUTER_WILDCARD_CHARACTER]) {
                        found = YES;
                        subRoutes = subRoutes[key];
                        break;
                    } else if ([key hasPrefix:@":"]) {
                        found = YES;
                        subRoutes = subRoutes[key];
                        NSString *newKey = [key substringFromIndex:1];
                        NSString *newPathComponent = pathComponent;
                    // 再做一下特殊处理，比如 :id.html -> :id
                        if ([self.class checkIfContainsSpecialCharacter:key]) {
                            NSCharacterSet *specialCharacterSet = [NSCharacterSet characterSetWithCharactersInString:specialCharacters];
                            NSRange range = [key rangeOfCharacterFromSet:specialCharacterSet];
                            if (range.location != NSNotFound) {
                            // 把 pathComponent 后面的部分也去掉
                                newKey = [newKey substringToIndex:range.location - 1];
                                NSString *suffixToStrip = [key substringFromIndex:range.location];
                                newPathComponent = [newPathComponent stringByReplacingOccurrencesOfString:suffixToStrip withString:@""];
                            }
                        }
                        parameters[newKey] = newPathComponent;
                        break;
                    }
                }
            }
            // 如果没有找到该 pathComponent 对应的 handler，则以上一层的 handler 作为 fallback
            if (!found && !subRoutes[@"_"]) {
                return nil;
            }
        }
    }
    
    // Extract Params From Query.
    NSArray<NSString *>*pathInfo = [url componentsSeparatedByString:@"?"];
    if (pathInfo.count > 1) {
        NSString *parametersString = [pathInfo objectAtIndex:1];
        NSArray <NSString *>*paramStringArr = [parametersString componentsSeparatedByString:@"&"];
        [paramStringArr enumerateObjectsUsingBlock:^(NSString *paramString ,NSUInteger idx ,BOOL *stop){
            NSArray<NSString *>*paramArr = [paramString componentsSeparatedByString:@"="];
            if (paramArr.count > 1) {
                NSString *key = [paramArr objectAtIndex:0];
                NSString *value = [paramArr objectAtIndex:1];
                parameters[key] = value;
            }
        }];
    }
    
    if (subRoutes[@"_"]) {
        parameters[@"block"] = [subRoutes[@"_"] copy];
    }
    
    return parameters;
}

- (void)removeURLPattern:(NSString *)URLPattern{
    NSMutableArray<NSString *>*pathComponents = [NSMutableArray arrayWithArray:[self pathComponentsFromURL:URLPattern]];
    
    // 只删除该 pattern 的最后一级
    if (pathComponents.count >= 1) {
        // 假如 URLPattern 为 a/b/c, components 就是 @"a.b.c" 正好可以作为 KVC 的 key
        NSString *components = [pathComponents componentsJoinedByString:@"."];
        NSMutableDictionary<NSString * ,id>*route = [self.routes valueForKeyPath:components];
        
        if (route.count >= 1) {
            NSString *lastComponent = [pathComponents lastObject];
            [pathComponents removeLastObject];
            
            // 有可能是根 key，这样就是 self.routes 了
            route = self.routes;
            if (pathComponents.count) {
                NSString *componentsWithoutLast = [pathComponents componentsJoinedByString:@"."];
                route = [self.routes valueForKeyPath:componentsWithoutLast];
            }
            [route removeObjectForKey:lastComponent];
        }
    }
}

- (NSArray<NSString *>*)pathComponentsFromURL:(NSString *)URL{
    NSMutableArray<NSString *>*pathComponents = [NSMutableArray array];
    if ([URL rangeOfString:@"://"].location != NSNotFound) {
        NSArray<NSString *>*pathSegments = [URL componentsSeparatedByString:@"://"];
        // 如果 URL 包含协议，那么把协议作为第一个元素放进去
        [pathComponents addObject:pathSegments[0]];
        
        // 如果只有协议，那么放一个占位符
        if ((pathSegments.count == 2 && ((NSString *)pathSegments[1]).length) || pathSegments.count < 2) {
            [pathComponents addObject:JLY_ROUTER_WILDCARD_CHARACTER];
        }
        
        URL = [URL substringFromIndex:[URL rangeOfString:@"://"].location + 3];
    }
    for (NSString *pathComponent in [[NSURL URLWithString:URL] pathComponents]) {
        @autoreleasepool {
            if ([pathComponent isEqualToString:@"/"]) continue;
            if ([[pathComponent substringToIndex:1] isEqualToString:@"?"]) break;
            [pathComponents addObject:pathComponent];
        }
    }
    
    return [pathComponents copy];
}
#pragma mark - SettersAndGetters
- (NSMutableDictionary <NSString * ,id>*)routes{
    if (!_routes) {
        _routes = [[NSMutableDictionary alloc] init];
    }
    return _routes;
}

#pragma mark - Utils

+ (BOOL)checkIfContainsSpecialCharacter:(NSString *)checkedString {
    NSCharacterSet *specialCharactersSet = [NSCharacterSet characterSetWithCharactersInString:specialCharacters];
    return [checkedString rangeOfCharacterFromSet:specialCharactersSet].location != NSNotFound;
}

@end
