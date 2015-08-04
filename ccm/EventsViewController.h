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

@interface EventsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, DataControllerDelegate>

@property NSArray *content;
@property (weak, nonatomic) IBOutlet UITableView *table;
- (IBAction)swipe:(id)sender;
- (IBAction)swipeLeft:(id)sender;

@property NSIndexPath *selectedRow;

@end
