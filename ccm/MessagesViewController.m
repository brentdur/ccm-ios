//
//  MessagesViewController.m
//  ccm
//
//  Created by Brenton Durkee on 7/30/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "MessagesViewController.h"

@interface MessagesViewController ()

@end

@implementation MessagesViewController

@synthesize content;
@synthesize selectedRow;
@synthesize refresh;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    content = [DataController getMessages];
    if([content count] == 0){
        [DataController setDelegate:self withType:ENTITY_MESSAGES];
    }
    
    SWRevealViewController *rvc = [self revealViewController];
    if (rvc){
        [[self moreButton] setTarget:[self revealViewController]];
        [[self moreButton] setAction:@selector(revealToggle:)];
        [[self view] addGestureRecognizer:[[self revealViewController] panGestureRecognizer]];
    }
    
    [refresh addTarget:self action:@selector(refreshStuff) forControlEvents:UIControlEventValueChanged];
}

-(void) viewWillAppear:(BOOL)animated{
    if ([content count] != [DataController getNumMsgs]){
        [self didUpdateData];
    }
}

-(void) refreshStuff{
    NSLog(@"refresh");
    [DataController setDelegate:self withType:ENTITY_MESSAGES];
    [DataController sync];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) didUpdateData{
    NSLog(@"did update messages");
    content = [DataController getMessages];
    [[self tableView] reloadData];
    [refresh endRefreshing];
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [content count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellMsg";
    
    MessagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [[MessagesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.label1.text = [(Messages *)content[indexPath.row] subject];
    cell.label2.text = [(Messages *)content[indexPath.row] from];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setSelectedRow:indexPath];
//    MessageDetailViewController *dv = [[self storyboard] instantiateViewControllerWithIdentifier:@"MsgDetail"];
//    [[self navigationController] pushViewController:dv animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"MsgDetail" sender:self];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"MsgDetail"]) {
        MsgTableViewController *detailViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self selectedRow];
        [detailViewController setData:(Messages *) content[indexPath.row]];
    }
}


- (IBAction)swipeLeft:(id)sender {
    [[self tabBarController] setSelectedViewController:[[[self tabBarController] viewControllers]objectAtIndex:1]];
}

@end
