//
//  MMLocationManager.m
//  MMLocationManager
//
//  Created by Chen Yaoqiang on 13-12-24.
//  Copyright (c) 2013年 Chen Yaoqiang. All rights reserved.
//

#import "JLYLocation.h"

@interface JLYLocation ()

@property (nonatomic, copy) LocationBlock locationBlock;
@property (nonatomic, copy) NSStringBlock cityBlock;
@property (nonatomic, copy) NSStringBlock addressBlock;
@property (nonatomic, copy) LocationErrorBlock errorBlock;
@property (nonatomic ,copy) AreaBlock areaBlock;

@end

@implementation JLYLocation

static JLYLocation * instance = nil;

+ (instancetype)shareLocation{
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

- (void) getLocationCoordinate:(LocationBlock) locaiontBlock{
    self.locationBlock = [locaiontBlock copy];
    [self startLocation];
}

- (void) getLocationCoordinate:(LocationBlock) locaiontBlock  withAddress:(NSStringBlock) addressBlock{
    self.locationBlock = locaiontBlock;
    self.addressBlock = addressBlock;
    [self startLocation];
}

- (void) getAddress:(NSStringBlock)addressBlock{
    self.addressBlock = addressBlock;
    [self startLocation];
}

- (void) getCity:(NSStringBlock)cityBlock{
    self.cityBlock = cityBlock;
    [self startLocation];
}

- (void) getCity:(AreaBlock)areaBlock error:(LocationErrorBlock)errorBlock{
    self.areaBlock =areaBlock;
    self.errorBlock = [errorBlock copy];
    [self startLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation * newLocation = locations.lastObject;
    self.lastCoordinate = newLocation.coordinate;
    
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    CLGeocodeCompletionHandler handle = ^(NSArray *placemarks,NSError *error)
    {
        if (placemarks.count > 0) {
            CLPlacemark *place = [placemarks objectAtIndex:0];
            self.lastCity = place.administrativeArea;
            self.lastAddress = place.name;
        }
        [self stopLocation];
        
        _userLocaiton = [[CLLocation alloc] initWithLatitude:_lastCoordinate.latitude longitude:_lastCoordinate.longitude];
        
        if (_cityBlock) {
            _cityBlock(_lastCity);
            _cityBlock = nil;
        }
        
        if (_locationBlock) {
            _locationBlock(_lastCoordinate);
            _locationBlock = nil;
        }
        
        if (_addressBlock) {
            
            _addressBlock(_lastAddress);
            _addressBlock = nil;
        }
        if (_areaBlock) {
            _areaBlock(_lastCity,_lastCoordinate ,_lastAddress);
            _areaBlock = nil;
        }
    };
    
    [clGeoCoder reverseGeocodeLocation:newLocation completionHandler:handle];
    
}

-(void)startLocation{
    if (_mapView) {
        _mapView = nil;
    }
    _mapView = [[CLLocationManager alloc] init];
    _mapView.delegate = self;
    [_mapView setDesiredAccuracy:kCLLocationAccuracyBest];
    if ([_mapView respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_mapView requestAlwaysAuthorization];
    }
    [_mapView startUpdatingLocation];
}

-(void)stopLocation{
    [_mapView stopUpdatingLocation];
    _mapView = nil;
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    [self stopLocation];
}

@end
