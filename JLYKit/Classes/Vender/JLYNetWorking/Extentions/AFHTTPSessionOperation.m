//
//  AFHTTPSessionOperation.m
//
//  Created by Robert Ryan on 8/6/15.
//  Copyright (c) 2015 Robert Ryan. All rights reserved.
//

#import "AFHTTPSessionOperation.h"
#import "AFNetworking.h"

@interface AFHTTPSessionManager (DataTask)

// this method is not publicly defined in @interface in .h, so we need to define our own interface for it

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;
@end

@interface AFHTTPSessionOperation ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong, readwrite, nullable) NSURLSessionTask *task;

@end

@implementation AFHTTPSessionOperation

+ (instancetype)operationWithManager:(__kindof AFHTTPSessionManager *)manager
                          HTTPMethod:(NSString *)method
                           URLString:(NSString *)URLString
                          parameters:(id)parameters
                      uploadProgress:(void (^)(NSProgress * _Nonnull))uploadProgress
                    downloadProgress:(void (^)(NSProgress * _Nonnull))downloadProgress
                             success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nonnull))success
                             failure:(void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nonnull))failure {
    
    AFHTTPSessionOperation *operation = [[self alloc] init];
    NSURLSessionTask *task = nil;
    if ([method isEqualToString:@"Image"]) {
        NSMutableDictionary<NSString * ,id> *paramDic = [NSMutableDictionary dictionary];
        paramDic = [parameters mutableCopy];
        [paramDic removeObjectForKey:@"photo"];
        task = [manager POST:URLString
                  parameters:paramDic
   constructingBodyWithBlock:^(id<AFMultipartFormData>formData){
       NSDictionary<NSString * ,id> *photo = parameters[@"photo"];
       if ([photo count] > 0) {
           NSString *path = photo[@"path"];
           if (![path hasPrefix:@"http"]) {
               NSData *imageData = UIImageJPEGRepresentation([UIImage imageWithContentsOfFile:photo[@"path"]], 0.5);
               [formData appendPartWithFileData:imageData
                                           name:@"image"
                                       fileName:photo[@"name"]
                                       mimeType:@"image/png"];
           }else{
               
           }
       }
   }
                    progress:^(NSProgress *uploadProgress){
                        
                    }
                     success:^(NSURLSessionDataTask *task, id responseObject){
                         if (success) {
                             success(task, responseObject);
                         }
                         [operation completeOperation];
                     }
                     failure:^(NSURLSessionDataTask *task, NSError *error) {
                         if (failure) {
                             failure(task, error);
                         }
                         [operation completeOperation];
                     }];
    }else{
        task = [manager dataTaskWithHTTPMethod:method
                                     URLString:URLString
                                    parameters:parameters
                                uploadProgress:uploadProgress
                              downloadProgress:downloadProgress
                                       success:^(NSURLSessionDataTask *task, id responseObject){
                                           if (success) {
                                               success(task, responseObject);
                                           }
                                           [operation completeOperation];
                                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                           if (failure) {
                                               failure(task, error);
                                           }
                                           [operation completeOperation];
                                       }];
    }
    
    
    operation.task = task;
    
    return operation;
}

- (void)main {
    [self.task resume];
}

- (void)completeOperation {
    self.task = nil;
    [super completeOperation];
}

- (void)cancel {
    [self.task cancel];
    [super cancel];
}

@end
