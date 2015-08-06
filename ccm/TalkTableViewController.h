//
//  TalkTableViewController.h
//  ccm
//
//  Created by Brenton Durkee on 8/2/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Talks.h"
#import "DateUtil.h"
#import "StaticDataTableViewController.h"

@interface TalkTableViewController : StaticDataTableViewController
- (IBAction)refTap:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *ref;
@property (weak, nonatomic) IBOutlet UITextView *fillRef;
@property (weak, nonatomic) IBOutlet UITextView *outline;
@property (weak, nonatomic) IBOutlet UITableViewCell *fullRefCell;

@property BOOL cellHidden;

@property Talks *data;

@end
