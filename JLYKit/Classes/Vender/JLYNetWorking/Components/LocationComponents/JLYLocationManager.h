//
//  NDBLocationManager.h
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYAPIBaseManager.h"
#import "JLYCityListManager.h"
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString * const JLYHDLocationManagerDidSuccessedLocateNotification;
UIKIT_EXTERN NSString * const JLYHDLocationManagerDidFailedLocateNotification;
UIKIT_EXTERN NSString * const JLYHDLocationManagerDidSwitchCityNotification;

typedef NS_ENUM(NSUInteger, JLYHDLocationManagerLocationResult) {
    JLYHDLocationManagerLocationResultDefault,              //默认状态
    JLYHDLocationManagerLocationResultLocating,             //定位中
    JLYHDLocationManagerLocationResultSuccess,              //定位成功
    JLYHDLocationManagerLocationResultFail,                 //定位失败
    JLYHDLocationManagerLocationResultParamsError,          //调用API的参数错了
    JLYHDLocationManagerLocationResultTimeout,              //超时
    JLYHDLocationManagerLocationResultNoNetwork,            //没有网络
    JLYHDLocationManagerLocationResultNoContent             //API没返回数据或返回数据是错的
};

typedef NS_ENUM(NSUInteger, JLYHDLocationManagerLocationServiceStatus) {
    JLYHDLocationManagerLocationServiceStatusDefault,               //默认状态
    JLYHDLocationManagerLocationServiceStatusOK,                    //定位功能正常
    JLYHDLocationManagerLocationServiceStatusUnknownError,          //未知错误
    JLYHDLocationManagerLocationServiceStatusUnAvailable,           //定位功能关掉了
    JLYHDLocationManagerLocationServiceStatusNoAuthorization,       //定位功能打开，但是用户不允许使用定位
    JLYHDLocationManagerLocationServiceStatusNoNetwork,             //没有网络
    JLYHDLocationManagerLocationServiceStatusNotDetermined          //用户还没做出是否要允许应用使用定位功能的决定，第一次安装应用的时候会提示用户做出是否允许使用定位功能的决定
};

@interface JLYLocationManager : JLYAPIBaseManager<JLYAPIManager,JLYAPIManagerValidator, JLYAPIManagerParamSourceDelegate, JLYAPIManagerApiCallBackDelegate, CLLocationManagerDelegate>

@property (nonatomic, copy, readonly) NSString *selectedCityId;
@property (nonatomic, copy, readonly) NSString *selectedCityName;
@property (nonatomic, copy, readonly) CLLocation *selectedCityLocation;

@property (nonatomic, copy, readonly) NSString *locatedCityId;
@property (nonatomic, copy, readonly) NSString *locatedCityName;
@property (nonatomic, copy, readonly) CLLocation *locatedCityLocation;

@property (nonatomic, copy, readonly) NSString *currentCityId;
@property (nonatomic, copy, readonly) NSString *currentCityName;
@property (nonatomic, copy, readonly) CLLocation *currentCityLocation;

@property (nonatomic, readonly) BOOL isUsingLocatedData;

@property (nonatomic, readonly) JLYHDLocationManagerLocationResult locationResult;
@property (nonatomic, readonly) JLYHDLocationManagerLocationServiceStatus locationStatus;

@property (nonatomic, strong) JLYCityListManager *cityListManager;

+ (instancetype)sharedInstance;

- (BOOL)isInLocatedCity;
- (BOOL)isInLocatedCityWithLocation:(CLLocation *)location;

- (BOOL)checkLocationAndShowingAlert:(BOOL)showingAlert;

- (void)startLocation;
- (void)stopLocation;
- (void)restartLocation;

- (void)switchToCityWithCityId:(NSString *)cityId;
- (void)loadCurrentCityDataFromPlist;

@end
NS_ASSUME_NONNULL_END
