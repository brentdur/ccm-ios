//
//  TalkTableViewController.h
//  ccm
//
//  Created by Brenton Durkee on 8/2/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Talks.h"

@interface TalkTableViewController : UITableViewController
- (IBAction)refTap:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *subject;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *ref;
@property (weak, nonatomic) IBOutlet UITextView *fillRef;
@property (weak, nonatomic) IBOutlet UITextView *outline;

@property BOOL cellHidden;

@property Talks *data;

@end
