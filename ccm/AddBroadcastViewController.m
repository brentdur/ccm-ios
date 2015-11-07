//
//  AddBroadcastViewController.m
//  RUF City Campus
//
//  Created by Brenton Durkee on 11/5/15.
//  Copyright © 2015 Brenton Durkee. All rights reserved.
//

#import "AddBroadcastViewController.h"

@implementation AddBroadcastViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    
    [self setGroupData:[DataController getGroups]];
    [self setGroupName:[[[self groupData] objectAtIndex:0] name]];
    NSMutableArray *stringData;
    
    for (int i = 0; i < _groupData.count; i++){
        [stringData addObject:[[_groupData objectAtIndex:i] name]];
    }
    
    _groupsSelector = [[MultiSelectViewController alloc] init];
    [_groupsSelector setData:stringData];
    
    [[self groupsSelector] setTableView:_forTable];
    
    _aboutSelector = [[MultiSelectViewController alloc] init];
    [_aboutSelector setData:@[@"a", @"b", @"c"]];
    
    [[self aboutSelector] setTableView:_aboutTable];
    
    _isSyncCast = false;
    
}
     
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

- (IBAction)done:(id)sender {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    if(!_isSyncCast) {
        [data setValue:[_titleField text] forKey:@"title"];
        [data setValue:[_messageTextView text] forKey:@"message"];
    }
    [data setValue:[_aboutSelector selections] forKey:@"syncs"];
    [data setValue:[_groupsSelector selections] forKey:@"recepients"];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:data];
    
    [[self view] makeToastActivity];
    [DataController addConvoWithData:dic andHandler:^(NSMutableArray *data, NSError *error) {
        [[self view] hideToastActivity];
        if (error) {
            [[[self parentViewController] view] makeToast:@"Error" duration:3.0 position:CSToastPositionLower];
        }
        else {
            [[[self parentViewController] view] makeToast:@"Success" duration:3.0 position:CSToastPositionLower];
            [[self navigationController] popViewControllerAnimated:YES];
        }
    }];
}

//sync cast or nah, title, about: data items, for: groups, message

- (void) hideCellAnimated:(BOOL) anim hidden:(BOOL) hide {
    [self setHideSectionsWithHiddenRows:anim];
    [self cell:[self messageCell] setHidden:hide];
    [self cell:[self titleCell] setHidden:hide];
    [self reloadDataAnimated:anim];
}

- (IBAction)syncCastSwitch:(id)sender {
    _isSyncCast = !_isSyncCast;
    [self hideCellAnimated:YES hidden:_isSyncCast];
}
@end
