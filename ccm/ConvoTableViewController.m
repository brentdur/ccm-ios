//
//  ConvoTableViewController.m
//  RUF City Campus
//
//  Created by Brenton Durkee on 11/5/15.
//  Copyright © 2015 Brenton Durkee. All rights reserved.
//

#import "ConvoTableViewController.h"

@implementation ConvoTableViewController

@synthesize data;

-(void) viewDidLoad {
    [super viewDidLoad];
    
    //TODO set the label views here
}

-(void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //TODO set this to number of cells
    return 1;
}

//title, messages, send message, delete

- (void) markAsKilled {
    NSDictionary *dic = @{@"conversation": [data getIdd]};
    [[self view] makeToastActivity];
    [DataController putKillConvo:dic andHandler:^(NSMutableArray *data, NSError *error) {
        [[self view] hideToastActivity];
        if(error) {
            [[[self parentViewController] view] makeToast:@"Error" duration:3.0 position:CSToastPositionLower];
        }
        else {
            [[[self parentViewController] view] makeToast:@"Success" duration:3.0 position:CSToastPositionLower];
            [[self navigationController] popViewControllerAnimated:YES];
        }
    }];
}

- (IBAction)delete:(id)sender {
    UIAlertController *cont = [UIAlertController alertControllerWithTitle:@"Are you sure?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        return;
    }];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self markAsKilled];
    }];
    [self presentViewController:cont animated:YES completion:nil];
}

@end
