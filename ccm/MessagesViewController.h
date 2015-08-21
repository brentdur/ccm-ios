//
//  MessagesViewController.h
//  ccm
//
//  Created by Brenton Durkee on 7/30/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constaints.h"
#import "DataController.h"
#import "Messages.h"
#import "Topics.h"
#import "MessagesTableViewCell.h"
#import "MsgTableViewController.h"

@interface MessagesViewController : UITableViewController
@property NSArray *content;
@property NSArray *sections;

@property NSDictionary *splits;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *moreButton;
@property (weak, nonatomic) IBOutlet UIRefreshControl *refresh;

@property NSIndexPath *selectedRow;
- (IBAction)edit:(id)sender;

@end
