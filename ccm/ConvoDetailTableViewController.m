//
//  ConvoDetailTableViewController.m
//  RUF City Campus
//
//  Created by Brenton Durkee on 11/16/15.
//  Copyright © 2015 Brenton Durkee. All rights reserved.
//

#import "ConvoDetailTableViewController.h"

@interface ConvoDetailTableViewController ()

#define TITLE_CELL_ID @"ConvoTitle"
#define LIST_CELL_ID @"MessageList"
#define SEND_CELL_ID @"SendMessage"

@end

@implementation ConvoDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[self table] setDelegate:self];
    [[self table] setDataSource:self];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    NSString *reuseID;
    
    if (indexPath.row == 0){
        reuseID = TITLE_CELL_ID;
    }
    else if (indexPath.row == 1){
        reuseID = LIST_CELL_ID;
    }
    else {
        reuseID = SEND_CELL_ID;
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    
    if (cell == nil && indexPath.row == 1) {
        MessagesTableViewController *mvc = [[MessagesTableViewController alloc] initWithNibName:@"MessagesTableViewController" bundle:nil];
        [cell addSubview:mvc.view];
    }
    
    // Configure the cell...
    
    if (indexPath.row == 0){
        [[self titleLabel] setText:@"Title!!"];
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sendMessage:(id)sender {
}
@end
