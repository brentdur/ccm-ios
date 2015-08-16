//
//  AddSignupViewController.h
//  ccm
//
//  Created by Brenton Durkee on 8/10/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StaticDataTableViewController.h"
#import "DataController.h"
#import "UIView+Toast.h"

@interface AddSignupViewController : StaticDataTableViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

//moving cells
//textview
@property (weak, nonatomic) IBOutlet UITableViewCell *cell;
@property (weak, nonatomic) IBOutlet UITableViewCell *cell2;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property NSArray *locData;
@property NSString *locName;

//all fields
//label for text view
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *dateInfo;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *locationNameField;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;


//done button click
- (IBAction)done:(id)sender;

@end
