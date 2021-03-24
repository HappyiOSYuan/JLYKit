//
//  NDBServiceFactory.m
//  NDBAPIManager
//
//  Created by TJBT on 15/9/15.
//  Copyright (c) 2015年 TIANJIN BEITA TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "JLYServiceFactory.h"

/*************************************************************************/

NSString * const kGFServiceManager = @"GFServiceManager";
NSString * const kGFLogonServiceManager = @"GFLogonServiceManager";
NSString * const kGFCommodityServiceManager = @"GFCommodityServiceManager";
NSString * const kGFProjectServiceManager = @"GFProjectServiceManager";
NSString * const kGFProjectManageServiceManager = @"GFProjectManangeServiceManager";
NSString * const kGFSalesManageServiceManager = @"GFSalesManageServiceManager";
NSString * const kGFRequestServiceManager = @"GFRequestServiceManager";
NSString * const kGFContactServiceManager = @"GFContactServiceManager";
NSString * const kGFCarManageServiceManager = @"GFCarManageServiceManager";
NSString * const kGFReimburseServiceManager = @"GFReimburseServiceManager";
NSString * const kGFHomeServiceManager = @"GFHomeServiceManager";
NSString * const kGFResourceServiceManager = @"GFResourceServiceManager";
NSString * const kGFLoginRecordServiceManager = @"GFLoginRecordServiceManager";
NSString * const kGFCustomerServiceManager = @"GFCustomerServiceManager";
NSString * const kGFStaffArchivesServiceManager = @"GFStaffArchivesServiceManager";
NSString * const kGFDailyServiceManager = @"GFDailyServiceManager";
NSString * const kGFVerifyCodeServiceManager = @"GFVerifyCodeServiceManager";
NSString * const kGFResourceHandleServiceManager = @"GFResourceHandleServiceManager";
NSString * const kGFOrderServiceManager = @"GFOrderServiceManager";
NSString * const kGFOrderSaleServiceManager = @"GFOrderSaleServiceManager";
NSString * const kGFOldOrderServiceManager = @"GFOldOrderServiceManager";
NSString * const kGFDriverSettingServiceManager = @"GFDriverSettingServiceManager";
NSString * const kGFHomePopedomServiceManager = @"GFHomePopedomServiceManager";
NSString * const kGFApprovalServiceManager = @"GFApprovalServiceManager";
NSString * const kGFWorkAttendanceServiceManager = @"GFWorkAttendanceServiceManager";
NSString * const kGFRecruitServiceManager = @"GFRecruitServiceManager";
NSString * const kGFHandleForumServiceManager = @"GFHandleForumServiceManager";
NSString * const kGFStorageSettingServiceManager = @"GFStorageSettingServiceManager";
NSString * const kGFMemoAndScheduleServiceManager  = @"GFMemoAndScheduleServiceManager";
NSString * const kGFComplaintServiceManager = @"GFComplaintServiceManager";
NSString * const kGFInvoiceServiceManager = @"GFInvoiceServiceManager";
NSString * const kGFStartManageServiceManager = @"GFStartManageServiceManager";
NSString * const kGFSalaryTreasureServiceManager = @"GFSalaryTreasureServiceManager";
NSString * const kGFWorkRolePrincipalsServiceManager = @"GFWorkRolePrincipalsServiceManager";
NSString * const kGFFinancialUpdateServiceManager = @"GFFinancialUpdateServiceManager";
NSString * const kGFUserInfoServiceManager = @"GFUserInfoServiceManager";
NSString * const kGFAccountServiceManager = @"GFAccountServiceManager";
NSString * const kGFForumServiceManager = @"GFForumServiceManager";
NSString * const kGFHomeCustomerServiceManager = @"GFHomeCustomerServiceManager";
NSString * const kGFSuspendPurMATServiceManager = @"GFSuspendPurMATServiceManager";
NSString * const kGFFinancialBankAccountServiceManager = @"GFFinancialBankAccountServiceManager";
NSString * const kGFFinancialChequeServiceManager = @"GFFinancialChequeServiceManager";
NSString * const kGFFinancialInvoiceServiceManager = @"GFFinancialInvoiceServiceManager";


@interface JLYServiceFactory ()

@property (nonatomic, strong) NSMutableDictionary *serviceStorage;

@end

@implementation JLYServiceFactory

#pragma mark - getters and setters
- (NSMutableDictionary<NSString * ,id> *)serviceStorage{
    if (_serviceStorage == nil) {
        _serviceStorage = [NSMutableDictionary dictionary];
    }
    return _serviceStorage;
}

#pragma mark - life cycle
static JLYServiceFactory * instance = nil;

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

#pragma mark - public methods
- (__kindof JLYService<JLYServiceProtocal> *)serviceWithIdentifier:(NSString *)identifier{
    if (self.serviceStorage[identifier] == nil) {
        self.serviceStorage[identifier] = [self newServiceWithIdentifier:identifier];
    }
    return self.serviceStorage[identifier];
}

#pragma mark - private methods
- (__kindof JLYService<JLYServiceProtocal> *)newServiceWithIdentifier:(NSString *)identifier{
    if ([identifier isEqualToString:kGFServiceManager]) {
        return [[NSClassFromString(kGFServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFLogonServiceManager]){
        return [[NSClassFromString(kGFLogonServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFCommodityServiceManager]){
        return [[NSClassFromString(kGFCommodityServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFProjectServiceManager]){
        return [[NSClassFromString(kGFProjectServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFProjectManageServiceManager]){
        return [[NSClassFromString(kGFProjectManageServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFSalesManageServiceManager]){
        return [[NSClassFromString(kGFSalesManageServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFRequestServiceManager]){
        return [[NSClassFromString(kGFRequestServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFContactServiceManager]){
        return [[NSClassFromString(kGFContactServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFCarManageServiceManager]){
        return [[NSClassFromString(kGFCarManageServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFReimburseServiceManager]){
        return [[NSClassFromString(kGFReimburseServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFHomeServiceManager]){
        return [[NSClassFromString(kGFHomeServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFResourceServiceManager]){
        return [[NSClassFromString(kGFResourceServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFLoginRecordServiceManager]){
        return [[NSClassFromString(kGFLoginRecordServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFCustomerServiceManager]){
        return [[NSClassFromString(kGFCustomerServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFStaffArchivesServiceManager]){
        return [[NSClassFromString(kGFStaffArchivesServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFDailyServiceManager]){
        return [[NSClassFromString(kGFDailyServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFVerifyCodeServiceManager]){
        return [[NSClassFromString(kGFVerifyCodeServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFResourceHandleServiceManager]){
        return [[NSClassFromString(kGFResourceHandleServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFOrderServiceManager]){
        return [[NSClassFromString(kGFOrderServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFOrderSaleServiceManager]){
        return [[NSClassFromString(kGFOrderSaleServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFOldOrderServiceManager]){
        return [[NSClassFromString(kGFOldOrderServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFDriverSettingServiceManager]){
        return [[NSClassFromString(kGFDriverSettingServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFHomePopedomServiceManager]){
        return [[NSClassFromString(kGFHomePopedomServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFApprovalServiceManager]) {
        return [[NSClassFromString(kGFApprovalServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFWorkAttendanceServiceManager]) {
        return [[NSClassFromString(kGFWorkAttendanceServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFRecruitServiceManager]) {
        return [[NSClassFromString(kGFRecruitServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFHandleForumServiceManager]) {
         return [[NSClassFromString(kGFHandleForumServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFStorageSettingServiceManager]) {
         return [[NSClassFromString(kGFStorageSettingServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFMemoAndScheduleServiceManager]) {
        return [[NSClassFromString(kGFMemoAndScheduleServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFComplaintServiceManager]) {
        return [[NSClassFromString(kGFComplaintServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFInvoiceServiceManager]) {
        return [[NSClassFromString(kGFInvoiceServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFStartManageServiceManager]) {
        return [[NSClassFromString(kGFStartManageServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFSalaryTreasureServiceManager]) {
        return [[NSClassFromString(kGFSalaryTreasureServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFFinancialUpdateServiceManager]) {
        return [[NSClassFromString(kGFFinancialUpdateServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFWorkRolePrincipalsServiceManager]) {
        return [[NSClassFromString(kGFWorkRolePrincipalsServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFUserInfoServiceManager]) {
        return [[NSClassFromString(kGFUserInfoServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFAccountServiceManager]) {
        return [[NSClassFromString(kGFAccountServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFForumServiceManager]) {
        return [[NSClassFromString(kGFForumServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFHomeCustomerServiceManager]) {
        return [[NSClassFromString(kGFHomeCustomerServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFSuspendPurMATServiceManager]) {
        return [[NSClassFromString(kGFSuspendPurMATServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFFinancialBankAccountServiceManager]) {
        return [[NSClassFromString(kGFFinancialBankAccountServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFFinancialChequeServiceManager]) {
        return [[NSClassFromString(kGFFinancialChequeServiceManager) alloc] init];
    }
    if ([identifier isEqualToString:kGFFinancialInvoiceServiceManager]) {
        return [[NSClassFromString(kGFFinancialInvoiceServiceManager) alloc] init];
    }
    return nil;
}

@end
