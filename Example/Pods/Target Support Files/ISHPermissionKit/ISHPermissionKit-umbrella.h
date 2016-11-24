#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ISHPermissionCategory.h"
#import "ISHPermissionKit.h"
#import "ISHPermissionRequestViewController.h"
#import "ISHPermissionsViewController.h"
#import "ISHPermissionRequest+All.h"
#import "ISHPermissionRequest.h"
#import "ISHPermissionRequestAccount.h"
#import "ISHPermissionRequestHealth.h"
#import "ISHPermissionRequestNotificationsLocal.h"
#import "ISHPermissionRequestNotificationsRemote.h"
#import "ISHPermissionRequestUserNotification.h"

FOUNDATION_EXPORT double ISHPermissionKitVersionNumber;
FOUNDATION_EXPORT const unsigned char ISHPermissionKitVersionString[];

