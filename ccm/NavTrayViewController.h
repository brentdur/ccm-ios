//
//  NavTrayViewController.h
//  ccm
//
//  Created by Brenton Durkee on 8/5/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "StaticDataTableViewController.h"

@interface NavTrayViewController : StaticDataTableViewController <SWRevealViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableViewCell *homeCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *sendCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *inboxCell;

@property NSString *currentID;
@property SWRevealViewController *rvc;

@property BOOL inboxEnabled;
@property BOOL sendEnabled;

@end
