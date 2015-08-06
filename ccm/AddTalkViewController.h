//
//  AddTalkViewController.h
//  ccm
//
//  Created by Brenton Durkee on 8/5/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataController.h"
#import "StaticDataTableViewController.h"


@interface AddTalkViewController : StaticDataTableViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UITextField *subjectField;
@property (weak, nonatomic) IBOutlet UITextField *authorField;
@property (weak, nonatomic) IBOutlet UITextField *dateField;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *done;

@end
