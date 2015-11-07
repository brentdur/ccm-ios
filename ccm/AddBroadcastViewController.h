//
//  AddBroadcastViewController.h
//  RUF City Campus
//
//  Created by Brenton Durkee on 11/5/15.
//  Copyright © 2015 Brenton Durkee. All rights reserved.
//

#import "StaticDataTableViewController.h"
#import "DataController.h"
#import "Groups.h"
#import "MultiSelectViewController.h"
#import "UIView+Toast.h"

@interface AddBroadcastViewController : StaticDataTableViewController

@property NSArray *groupData;
@property NSString *groupName;
@property (weak, nonatomic) IBOutlet UITableView *forTable;
@property (weak, nonatomic) IBOutlet UITableView *aboutTable;

@property MultiSelectViewController *groupsSelector;
@property MultiSelectViewController *aboutSelector;

@property BOOL isSyncCast;

- (IBAction)syncCastSwitch:(id)sender;
- (void) hideCellAnimated:(BOOL) anim hidden:(BOOL) hide;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;

@property (weak, nonatomic) IBOutlet UITableViewCell *messageCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *titleCell;

@end
