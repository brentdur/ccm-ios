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
#import "EventDetailViewController.h"

@interface EventsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property NSArray *content;

@property NSIndexPath *selectedRow;

@end
