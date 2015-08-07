//
//  TalksViewController.h
//  ccm
//
//  Created by Brenton Durkee on 8/1/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constaints.h"
#import "DataController.h"
#import "Talks.h"
#import "TalksTableViewCell.h"
#import "TalkTableViewController.h"
#import "SWRevealViewController.h"

@interface TalksViewController : UITableViewController

@property NSArray *content;

@property (weak, nonatomic) IBOutlet UIRefreshControl *refresh;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *moreButton;

@property NSIndexPath *selectedRow;

@end
