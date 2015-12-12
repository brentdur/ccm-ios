//
//  MessagesTableViewController.h
//  RUF City Campus
//
//  Created by Brenton Durkee on 11/16/15.
//  Copyright © 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessagesTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UITableViewCell *rightShark;
@property (strong, nonatomic) IBOutlet UITableViewCell *leftShark;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@property NSArray *leftText;
@property NSArray *rightText;
@property NSArray *order;

@end
