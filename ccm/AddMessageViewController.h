//
//  AddMessageViewController.h
//  ccm
//
//  Created by Brenton Durkee on 8/5/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataController.h"
#import "StaticDataTableViewController.h"
#import "DataController.h"
#import "SWRevealViewController.h"

@interface AddMessageViewController : StaticDataTableViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;


@property NSArray *groupData;
@property NSString *groupName;

@property NSArray *topicData;
@property NSString *topicId;

@property (weak, nonatomic) IBOutlet UITextField *subjectField;
@property (weak, nonatomic) IBOutlet UITextView *messageField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *moreButton;

- (IBAction)done:(id)sender;

@end
