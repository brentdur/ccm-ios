//
//  SignupTableViewController.h
//  ccm
//
//  Created by Brenton Durkee on 8/10/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Signups.h"
#import "DataController.h"
#import "UIView+Toast.h"

@interface SignupTableViewController : UITableViewController

@property Signups *data;

@property (weak, nonatomic) IBOutlet UITableViewCell *buttonCell;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UITextView *desc;
@property (weak, nonatomic) IBOutlet UILabel *total;

- (IBAction)add:(id)sender;

@end
