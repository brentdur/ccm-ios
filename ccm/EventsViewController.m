//
//  EventsViewController.m
//  ccm
//
//  Created by Brenton Durkee on 7/30/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "EventsViewController.h"

@interface EventsViewController ()

@end

@implementation EventsViewController

@synthesize content;
@synthesize refresh;
@synthesize parent;

- (void)viewDidLoad {
    [super viewDidLoad];
     NSLog(@"events did load");
    // Do any additional setup after loading the view.
    content = [DataController getEvents];
    if([content count] == 0){
        [DataController setDelegate:self withType:ENTITY_EVENT];
    }
    
    parent = (MainTabViewController *)[self tabBarController];
    
    if(![parent loaded]){
        NSLog(@"set delegate");
        [parent setTheDelegate:self];
    }
    else {
        [self permissionsSet];
    }
    
    [refresh addTarget:self action:@selector(refreshStuff) forControlEvents:UIControlEventValueChanged];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[self tabBarController] tabBar] setHidden:NO];
    if ([content count] != [DataController getNumEvents]){
        [self didUpdateData];
    }
    
}

-(void) refreshStuff{
    NSLog(@"refresh");
    [DataController setDelegate:self withType:ENTITY_EVENT];
    [DataController sync];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) didUpdateData{
    content = [DataController getEvents];
    [[self tableView] reloadData];
    [refresh endRefreshing];
}

-(void) permissionsSet{
    if(![parent canWriteEvents]){
        [[self bar] setRightBarButtonItem:nil];
    }
    UIBarButtonItem *left = [UIBarButtonItem alloc];
    
    if([parent isMinister]){
        left = [left initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(inbox:)];
    }
    else {
        left = [left initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(sendMsg:)];
    }
    [[self bar] setLeftBarButtonItem:left];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if ([content count] == 0){
//        [DataController setDelegate:self];
//    }
    return [content count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"Cell";
    
    EventsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [[EventsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.label1.text = [(Events *)content[indexPath.row] name];
    cell.label2.text = [DateUtil eventLittleString:[(Events *)content[indexPath.row] date]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setSelectedRow:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"EventDetail" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"EventDetail"]) {
        EventTableViewController *detailViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self selectedRow];
        [detailViewController setData:(Events *) content[indexPath.row]];
    }
}

- (IBAction) sendMsg:(id)sender {
    [[[self tabBarController] tabBar] setHidden:YES];
    [self performSegueWithIdentifier:@"SendMsg" sender:sender];
}

- (IBAction) inbox:(id)sender {
    [[[self tabBarController] tabBar] setHidden:YES];
    [self performSegueWithIdentifier:@"ShowInbox" sender:sender];
}

- (IBAction)swipe:(id)sender {
    
    
    [[self tabBarController] setSelectedViewController:[[[self tabBarController] viewControllers]objectAtIndex:0]];
    
}

- (IBAction)swipeLeft:(id)sender {
    [[self tabBarController] setSelectedViewController:[[[self tabBarController] viewControllers]objectAtIndex:2]];
}
@end
