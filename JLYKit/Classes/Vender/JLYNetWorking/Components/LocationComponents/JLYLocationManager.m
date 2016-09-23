//
//  NDBLocationManager.m
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYLocationManager.h"
#import "JLYNetworking.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NSString * const JLYHDLocationManagerDidSuccessedLocateNotification = @"JLYHDLocationManagerDidSuccessedLocateNotification";
NSString * const JLYHDLocationManagerDidFailedLocateNotification = @"JLYHDLocationManagerDidFailedLocateNotification";
NSString * const JLYHDLocationManagerDidSwitchCityNotification = @"JLYHDLocationManagerDidSwitchCityNotification";

@interface JLYLocationManager ()

@property (nonatomic, strong) CLGeocoder *geoCoder;
@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, copy, readwrite) NSString *locatedCityId;
@property (nonatomic, copy, readwrite) NSString *locatedCityName;
@property (nonatomic, copy, readwrite) CLLocation *locatedCityLocation;

@property (nonatomic, copy, readwrite) NSString *selectedCityId;
@property (nonatomic, copy, readwrite) NSString *selectedCityName;
@property (nonatomic, copy, readwrite) CLLocation *selectedCityLocation;

@property (nonatomic, assign, readwrite) BOOL isUsingLocatedData;

@property (nonatomic, assign, readwrite) JLYHDLocationManagerLocationResult locationResult;
@property (nonatomic, assign, readwrite) JLYHDLocationManagerLocationServiceStatus locationStatus;

@property (nonatomic, copy, readwrite) NSString *methodName;

//定位成功之后就不需要再通知到外面了，防止外面的数据变化。
@property (nonatomic) BOOL shouldNotifyOtherObjects;

@end

@implementation JLYLocationManager

@synthesize methodName = _methodName;

#pragma mark - getters and setters
- (NSString *)serviceType{
    return kJLYServiceManager;
}

- (JLYAPIManagerRequestType)requestType{
    return JLYAPIManagerRequestTypeGet;
}

- (CLGeocoder *)geoCoder{
    if (_geoCoder == nil) {
        _geoCoder = [[CLGeocoder alloc] init];
    }
    return _geoCoder;
}

- (CLLocationManager *)locationManager{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _locationManager;
}

- (JLYCityListManager *)cityListManager{
    if (_cityListManager == nil) {
        _cityListManager = [[JLYCityListManager alloc] init];
    }
    return _cityListManager;
}

- (NSString *)locatedCityId{
    if (_locatedCityId == nil) {
        return @"-1";
    } else {
        return _locatedCityId;
    }
}

- (NSString *)selectedCityId{
    if (_selectedCityId == nil) {
        return @"-1";
    } else {
        return _selectedCityId;
    }
}

- (NSString *)currentCityId{
    if (self.isUsingLocatedData) {
        return self.locatedCityId;
    } else {
        return self.selectedCityId;
    }
}

- (NSString *)currentCityName{
    return [self.cityListManager cityNameWithCityId:self.currentCityId];
}

- (CLLocation *)currentCityLocation{
    if (self.isUsingLocatedData) {
        return self.locatedCityLocation;
    } else {
        return self.selectedCityLocation;
    }
}

#pragma mark - life cycle
- (instancetype)init{
    self = [super init];
    if (self) {
        self.locationResult = JLYHDLocationManagerLocationResultDefault;
        self.locationStatus = JLYHDLocationManagerLocationServiceStatusDefault;
        
        _methodName = @"_methodName";
        
        self.delegate = self;
        self.paramSource = self;
        self.validator = self;
        
        self.shouldNotifyOtherObjects = YES;
        self.isUsingLocatedData = NO;
        
        self.cityListManager = [[JLYCityListManager alloc] init];
    }
    return self;
}

#pragma mark - public methods
static JLYLocationManager * instance = nil;

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

- (BOOL)isInLocatedCity{
    if ([self.currentCityId isEqualToString:self.locatedCityId]) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isInLocatedCityWithLocation:(CLLocation *)location{
    BOOL result = NO;
    
    NSDictionary *cityInfo = [self.cityListManager cityWithLocation:location];
    NSDictionary *locatedCityInfo = [self.cityListManager cityWithLocation:self.locationManager.location];
    
    if (cityInfo && locatedCityInfo) {
        NSString *cityId = cityInfo[@"cityId"];
        NSString *locatedCityId = locatedCityInfo[@"cityId"];
        
        if ([cityId isEqualToString:locatedCityId]) {
            result = YES;
        }
    }
    return result;
}

- (BOOL)checkLocationAndShowingAlert:(BOOL)showingAlert;{
    BOOL result = NO;
    BOOL serviceEnable = [self locationServiceEnabled];
    JLYHDLocationManagerLocationServiceStatus authorizationStatus = [self locationServiceStatus];
    if (authorizationStatus == JLYHDLocationManagerLocationServiceStatusOK && serviceEnable) {
        result = YES;
    }else if (authorizationStatus == JLYHDLocationManagerLocationServiceStatusNotDetermined) {
        result = YES;
    }else{
        result = NO;
    }
    
    if (serviceEnable && result) {
        result = YES;
    }else{
        result = NO;
    }
    
    if (result == NO) {
        [self failedLocationWithResultType:JLYHDLocationManagerLocationResultFail statusType:self.locationStatus];
    }
    
    if (showingAlert && result == NO) {
        NSString *message = @"请到“设置->隐私->定位服务”中开启定位";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"当前定位服务不可用" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    return result;
}

- (void)startLocation{
    if ([self checkLocationAndShowingAlert:NO]) {
        self.locationResult = JLYHDLocationManagerLocationResultLocating;
        [self.locationManager startUpdatingLocation];
    } else {
        [self failedLocationWithResultType:JLYHDLocationManagerLocationResultFail statusType:self.locationStatus];
    }
}

- (void)stopLocation{
    if ([self checkLocationAndShowingAlert:NO]) {
        [self.locationManager stopUpdatingLocation];
    }
}

- (void)restartLocation{
    [self stopLocation];
    [self startLocation];
}

- (void)switchToCityWithCityId:(NSString *)cityId{
    if ([self.currentCityId isEqualToString:cityId]) {
        return;
    }
    
    if ([self.locatedCityId isEqualToString:cityId]) {
        self.isUsingLocatedData = YES;
    } else {
        self.selectedCityId = cityId;
        self.selectedCityName = [self.cityListManager cityNameWithCityId:cityId];
        self.selectedCityLocation = [self.cityListManager cityLocationWithCityId:cityId];
        self.isUsingLocatedData = NO;
    }
    
    NSDictionary *cityInfo = @{@"cityId":[JLYLocationManager sharedInstance].currentCityId, @"cityName":[JLYLocationManager sharedInstance].currentCityName};
    [[JLYLocationManager sharedInstance].cityListManager saveCityToPlistWithData:cityInfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:JLYHDLocationManagerDidSwitchCityNotification object:nil userInfo:nil];
}

- (void)loadCurrentCityDataFromPlist{
    NSDictionary *cityInfo = [[JLYLocationManager sharedInstance].cityListManager loadCurrentCityDataFromPlist];
    self.isUsingLocatedData = NO;
    self.selectedCityId = cityInfo[@"cityId"];
    self.selectedCityName = cityInfo[@"cityName"];
    self.selectedCityLocation = [self.cityListManager cityLocationWithCityId:cityInfo[@"cityId"]];
}
#pragma mark - private methods
- (void)failedLocationWithResultType:(JLYHDLocationManagerLocationResult)result statusType:(JLYHDLocationManagerLocationServiceStatus)status{
    NSError *error;
    self.locationResult = result;
    self.locationStatus = status;
    [self locationManager:self.locationManager didFailWithError:error];
}

- (BOOL)locationServiceEnabled{
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationStatus = JLYHDLocationManagerLocationServiceStatusOK;
        return YES;
    } else {
        self.locationStatus = JLYHDLocationManagerLocationServiceStatusUnknownError;
        return NO;
    }
}

- (JLYHDLocationManagerLocationServiceStatus)locationServiceStatus{
    self.locationStatus = JLYHDLocationManagerLocationServiceStatusUnknownError;
    BOOL serviceEnable = [CLLocationManager locationServicesEnabled];
    if (serviceEnable) {
        CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
        switch (authorizationStatus) {
            case kCLAuthorizationStatusNotDetermined:
                self.locationStatus = JLYHDLocationManagerLocationServiceStatusNotDetermined;
                break;
                
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
            case kCLAuthorizationStatusAuthorizedAlways:
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                self.locationStatus = JLYHDLocationManagerLocationServiceStatusOK;
                break;
#else
            case kCLAuthorizationStatusAuthorized:
                self.locationStatus = JLYHDLocationManagerLocationServiceStatusOK;
#endif
            case kCLAuthorizationStatusDenied:
                self.locationStatus = JLYHDLocationManagerLocationServiceStatusNoAuthorization;
                break;
                
            default:
                if (![self isReachable]) {
                    self.locationStatus = JLYHDLocationManagerLocationServiceStatusNoNetwork;
                }
                break;
        }
    } else {
        self.locationStatus = JLYHDLocationManagerLocationServiceStatusUnAvailable;
    }
    return self.locationStatus;
}

- (void)fetchCityInfoWithLocation:(CLLocation *)location geocoder:(CLGeocoder *)geocoder{
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placeMarkArray, NSError *error){
        CLPlacemark *placemark = [placeMarkArray lastObject];
        if (placemark) {
            NSString *cityName = nil;
            NSDictionary *addressDictionary = placemark.addressDictionary;
            for (NSString *key in addressDictionary.allKeys) {
                
                if ([key isEqualToString:@"City"]) {
                    NSString *completeCityName = addressDictionary[@"City"];
                    //上海市 => 上海
                    cityName = [completeCityName substringToIndex:(completeCityName.length - 1)];
                    break;
                }
                
                if ([key isEqualToString:@"State"]) {
                    //上海市只在"State"中出现，有可能直辖市都只是在State中出现。
                    NSString *completeCityName = addressDictionary[@"State"];
                    //要检查一下这个state是不是包含“市”这个字，因为也有可能是江苏省。
                    NSRange range = [completeCityName rangeOfString:@"市"];
                    if (range.location != NSNotFound) {
                        cityName = [completeCityName substringToIndex:(completeCityName.length - 1)];
                        break;
                    }
                }
            }
            
            NSDictionary *cityInfo = nil;
            if (cityName == nil) {
                //没办法，geocoder解析不出来就只能按照老方法查表了。。。
                cityInfo = [self.cityListManager cityWithLocation:location];
                if (cityInfo == nil) {
                    [self failedLocationWithResultType:JLYHDLocationManagerLocationResultFail statusType:self.locationStatus];
                    return;
                }
            }else{
                cityInfo = [self.cityListManager cityInfoWithCityName:cityName];
                if (cityInfo == nil) {
                    //有可能cityName是英文，所以cityInfo找不到，于是继续用老方法查表
                    cityInfo = [self.cityListManager cityWithLocation:location];
                    if (cityInfo == nil) {
                        //这样都查不出来？那只有往外面报错了
                        [self failedLocationWithResultType:JLYHDLocationManagerLocationResultFail statusType:self.locationStatus];
                        return;
                    }
                }
            }
            
            //如果城市没有变化，就不用重复发送定位成功的通知了
            if ([self.locatedCityId isEqualToString:cityInfo[@"id"]]) {
                return;
            }
            
            self.locatedCityLocation = location;
            self.locatedCityId = cityInfo[@"id"];
            self.locatedCityName = cityInfo[@"name"];
            
            if (self.locatedCityId == nil || self.locatedCityName == nil) {
                [self failedLocationWithResultType:JLYHDLocationManagerLocationResultFail statusType:self.locationStatus];
                return;
            }
            
            self.locationResult = JLYHDLocationManagerLocationResultSuccess;
            self.shouldNotifyOtherObjects = NO;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:JLYHDLocationManagerDidSuccessedLocateNotification object:self userInfo:nil];
        }
    }];
}
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //一开始启动的时候会跑到这边4次。所以如果以后的坐标都不变的话，后面的逻辑也就没必要再跑了。
    if (manager.location.coordinate.latitude == self.locatedCityLocation.coordinate.latitude && manager.location.coordinate.longitude == self.locatedCityLocation.coordinate.longitude) {
        return;
    }
    
    [self fetchCityInfoWithLocation:manager.location geocoder:self.geoCoder];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    //之前如果有定位成功的话，以后的定位失败就都不通知到外面了
    if (!self.shouldNotifyOtherObjects) {
        return;
    }
    
    //如果用户还没选择是否允许定位，则不认为是定位失败
    if (self.locationStatus == JLYHDLocationManagerLocationServiceStatusNotDetermined) {
        return;
    }
    
    //如果正在定位中，那么也不会通知到外面
    if (self.locationResult == JLYHDLocationManagerLocationResultLocating) {
        return;
    }
    
    self.locatedCityId = @"-1";
    [[NSNotificationCenter defaultCenter] postNotificationName:JLYHDLocationManagerDidFailedLocateNotification object:nil userInfo:nil];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    if (status == kCLAuthorizationStatusAuthorizedAlways || kCLAuthorizationStatusAuthorizedWhenInUse) {
        self.locationStatus = JLYHDLocationManagerLocationServiceStatusOK;
        [self restartLocation];
    } else {
        if (self.locationStatus != JLYHDLocationManagerLocationServiceStatusNotDetermined) {
            [self failedLocationWithResultType:JLYHDLocationManagerLocationResultDefault statusType:JLYHDLocationManagerLocationServiceStatusNoAuthorization];
        }
    }
#else
    if (status == kCLAuthorizationStatusAuthorized) {
        self.locationStatus = JLYHDLocationManagerLocationServiceStatusOK;
        [self restartLocation];
    } else {
        if (self.locationStatus != JLYHDLocationManagerLocationServiceStatusNotDetermined) {
            [self failedLocationWithResultType:JLYHDLocationManagerLocationResultDefault statusType:JLYHDLocationManagerLocationServiceStatusNoAuthorization];
        }
    }
#endif
}

#pragma mark - JLYAPIManagerValidator
- (BOOL)manager:(JLYAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data{
    //留给将来使用API的时候用
    return YES;
}

- (BOOL)manager:(JLYAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data{
    //留给将来使用API的时候用
    return YES;
}

#pragma mark - JLYAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(JLYAPIBaseManager *)manager{
    //留给将来使用API的时候用
    return nil;
}

#pragma mark - JLYAPIManagerApiCallBackDelegate
- (void)managerCallAPIDidSuccess:(JLYAPIBaseManager *)manager{
    //留给将来使用API的时候用
}

- (void)managerCallAPIDidFailed:(JLYAPIBaseManager *)manager{
    //留给将来使用API的时候用
}

@end
