//
//  ISHPermissionRequestViewControllerDelegate.h
//  ISHPermissionKit
//
//  Created by Felix Lamouroux on 26.06.14.
//  Copyright (c) 2014 iosphere GmbH. All rights reserved.
//

#import "ISHPermissionRequest.h"
@class ISHPermissionRequestViewController;
/**
 *  Internal protocol used between the ISHPermissionRequestViewController and the ISHPermissionsViewController.
 */
@protocol ISHPermissionRequestViewControllerDelegate <NSObject>
/**
 *  Called by the ISHPermissionRequestViewController when the user triggered one of the IBAction methods 
 *  and completed the action.
 *
 *  @param vc    ISHPermissionRequestViewController instance that triggered the call.
 *  @param state The current state of the permission category.
 *  @param error Any error (other than permission denied errors) that occured while requesting the permission.
 */
- (void)permissionRequestViewController:(nonnull ISHPermissionRequestViewController *)vc didCompleteWithState:(ISHPermissionState)state error:(nullable NSError *)error;

@end
