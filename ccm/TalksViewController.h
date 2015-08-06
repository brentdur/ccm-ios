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

@interface TalksViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *table;
@property NSArray *content;
- (IBAction)swipeRight:(id)sender;

@property NSIndexPath *selectedRow;

@end
