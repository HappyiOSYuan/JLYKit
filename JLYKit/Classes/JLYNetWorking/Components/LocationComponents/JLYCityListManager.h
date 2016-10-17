//
//  NDBCityListManager.h
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYAPIBaseManager.h"
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface JLYCityListManager : JLYAPIBaseManager<JLYAPIManager, JLYAPIManagerApiCallBackDelegate, JLYAPIManagerParamSourceDelegate, JLYAPIManagerValidator>

- (NSDictionary<NSString * ,id> *)cityWithLocation:(CLLocation *)location;
- (NSDictionary<NSString * ,id> *)cityInfoWithCityId:(NSString *)cityId;
- (NSDictionary<NSString * ,id> *)cityInfoWithCityName:(NSString *)cityName;

- (NSArray<NSString *> *)cities;
- (CLLocation *)cityLocationWithCityId:(NSString *)cityId;
- (CGPoint)cityOffsetWithCityId:(NSString *)cityId;
- (NSString *)cityNameWithCityId:(NSString *)cityId;

- (NSDictionary<NSString * ,id> *)cityIsOpenWithCityId:(NSString *)cityId;

- (BOOL)isLocation:(CLLocation *)location inCity:(NSString *)cityId;

//在程序进入后台的时候会把当前城市数据保存起来，用于下次打开的时候显示上次关闭时候的城市。
- (void)saveCityToPlistWithData:(NSDictionary<NSString * ,id> *)cityData;
- (NSDictionary<NSString * ,id> *)loadCurrentCityDataFromPlist;

@end
NS_ASSUME_NONNULL_END