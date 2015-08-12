//
//  MainTabViewController.h
//  ccm
//
//  Created by Brenton Durkee on 8/2/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constaints.h"

@interface MainTabViewController : UITabBarController

@property BOOL canWriteSignups;
@property BOOL canWriteTalks;
@property BOOL canWriteEvents;

@end
