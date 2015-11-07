//
//  AddConvoViewController.h
//  RUF City Campus
//
//  Created by Brenton Durkee on 11/5/15.
//  Copyright © 2015 Brenton Durkee. All rights reserved.
//

#import "StaticDataTableViewController.h"
#import "DataController.h"
#import "Topics.h"
#import "UIView+Toast.h"

@interface AddConvoViewController : StaticDataTableViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property NSArray *topicData;
@property NSString *topicId;

@property (weak, nonatomic) IBOutlet UITextField *subjectField;
@property (weak, nonatomic) IBOutlet UILabel *fieldLabel;

- (IBAction)done:(id)sender;

@end
