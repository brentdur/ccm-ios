//
//  ConvoDetailTableViewController.h
//  RUF City Campus
//
//  Created by Brenton Durkee on 11/16/15.
//  Copyright © 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessagesTableViewController.h"

@interface ConvoDetailTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView *table;

@property (weak, nonatomic) IBOutlet UITableViewCell *titleCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *sendCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *listCell;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (IBAction)sendMessage:(id)sender;

@end
