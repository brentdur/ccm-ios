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
#import "GCM.h"

@protocol PermissionSetDelegate;

@interface MainTabViewController : UITabBarController <DataControllerGroupsDelegate>

@property BOOL canWriteSignups;
@property BOOL canWriteTalks;
@property BOOL canWriteEvents;
@property BOOL canWriteConvo;
@property BOOL canWriteBroadcast;
@property BOOL isMinister;
@property BOOL loaded;


-(void) didUpdateData;
-(void) setTheDelegate:(id<PermissionSetDelegate>)delegate;

@end

@protocol PermissionSetDelegate
-(void) permissionsSet;

@end
