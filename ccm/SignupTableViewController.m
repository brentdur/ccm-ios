//
//  SignupTableViewController.m
//  ccm
//
//  Created by Brenton Durkee on 8/10/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "SignupTableViewController.h"

@interface SignupTableViewController ()

@end

@implementation SignupTableViewController

@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[self buttonCell] setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [self setTitle:[data name]];
    [[self date] setText:[data dateInfo]];
    [[self location] setText:[data location]];
    [[self desc] setText:[data desc]];
    [[self total] setText:[NSString stringWithFormat:@"Total: %@", [data memberCount]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 1) {
        NSString *query;
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]){
            query = [NSString stringWithFormat:@"comgooglemaps://?q=%@", [data address]];
        }
        else {
            query = [NSString stringWithFormat:@"http://maps.apple.com/?q=%@", [data address]];
        }
        query = [query stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:query]];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(IBAction)add:(id)sender{
    NSLog(@"add user to: %@", [data getIdd]);
    
    NSDictionary *dic = @{@"signup": [data getIdd]};
    [DataController putUserToSignup:dic];
    
    [data setMemberCount:[NSNumber numberWithLong:[[data memberCount] integerValue] + 1]];
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
