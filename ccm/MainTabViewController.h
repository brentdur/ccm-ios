//
//  MainTabViewController.h
//  ccm
//
//  Created by Brenton Durkee on 8/2/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constaints.h"
#import "DataController.h"

@protocol PermissionSetDelegate;

@interface MainTabViewController : UITabBarController <DataControllerGroupsDelegate>

@property id<PermissionSetDelegate> delegate;

@property BOOL canWriteSignups;
@property BOOL canWriteTalks;
@property BOOL canWriteEvents;
@property BOOL isMinister;
@property BOOL loaded;


-(void) didUpdateData;

@end

@protocol PermissionSetDelegate
-(void) permissionsSet;

@end
