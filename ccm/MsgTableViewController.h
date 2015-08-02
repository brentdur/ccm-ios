//
//  MsgTableViewController.h
//  ccm
//
//  Created by Brenton Durkee on 8/2/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Messages.h"


@interface MsgTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *subject;
@property (weak, nonatomic) IBOutlet UILabel *to;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UITextView *text;


@property Messages *data;

@end
