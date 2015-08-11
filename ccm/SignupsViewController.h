//
//  SignupsViewController.h
//  ccm
//
//  Created by Brenton Durkee on 8/10/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constaints.h"
#import "DataController.h"
#import "Signups.h"
#import "SignupsTableViewCell.h"
#import "SignupTableViewController.h"
#import "SWRevealViewController.h"


@interface SignupsViewController : UITableViewController <DataControllerDelegate>

@property NSArray *content;

@property (weak, nonatomic) IBOutlet UIRefreshControl *refresh;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *morebutton;

@property NSIndexPath *selectedRow;

@end
