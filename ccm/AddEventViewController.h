//
//  AddEventViewController.h
//  ccm
//
//  Created by Brenton Durkee on 8/5/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataController.h"
#import "StaticDataTableViewController.h"
#import "DataController.h"

@interface AddEventViewController : StaticDataTableViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableViewCell *cell;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell2;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property NSArray *locData;
@property NSString *locName;

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *dateField;
@property (weak, nonatomic) IBOutlet UITextField *locNameField;
@property (weak, nonatomic) IBOutlet UITextField *locAddField;
@property (weak, nonatomic) IBOutlet UILabel *fieldLabel;


- (IBAction)done:(id)sender;

@end
