//
//  BCTableViewController.h
//  RUF City Campus
//
//  Created by Brenton Durkee on 11/5/15.
//  Copyright © 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Broadcasts.h"
#import "DateUtil.h"
#import "UIView+Toast.h"
#import "DataController.h"

@interface BCTableViewController : UITableViewController


@property Broadcasts *data;

@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UITextView *messageText;

@property (weak, nonatomic) IBOutlet UINavigationItem *headerTitle;

- (IBAction)delete:(id)sender;

@end
