//
//  EventsViewController.h
//  ccm
//
//  Created by Brenton Durkee on 7/30/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constaints.h"

#import "DataController.h"
#import "Events.h"
#import "EventsTableViewCell.h"
#import "EventTableViewController.h"
#import "MainTabViewController.h"
#import "DateUtil.h"
#import "UIView+Toast.h"

@interface EventsViewController : UITableViewController <DataControllerDelegate, PermissionSetDelegate>

@property MainTabViewController *parent;
@property NSArray *content;
@property (weak, nonatomic) IBOutlet UINavigationItem *bar;

@property (weak, nonatomic) IBOutlet UIRefreshControl *refresh;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *moreButton;

@property NSIndexPath *selectedRow;

@end
