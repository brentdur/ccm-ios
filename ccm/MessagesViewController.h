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
#import "Conversations.h"
#import "Broadcasts.h"
#import "Topics.h"
#import "InboxTableViewCell.h"
#import "MsgTableViewController.h"
#import "UIView+Toast.h"

@interface MessagesViewController : UITableViewController
@property NSArray *broadcastContent;
@property NSArray *convoContent;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

@property (weak, nonatomic) IBOutlet UIRefreshControl *refresh;

@property NSIndexPath *selectedRow;
- (IBAction)edit:(id)sender;

@end
