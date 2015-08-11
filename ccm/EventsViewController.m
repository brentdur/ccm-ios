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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    content = [DataController getEvents];
    if([content count] == 0){
        [DataController setDelegate:self];
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
    if ([content count] != [DataController getNumEvents]){
        [self didUpdateData];
    }
}

-(void) refreshStuff{
    NSLog(@"refresh");
    [DataController setDelegate:self];
    [DataController sync];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) didUpdateData{
    NSLog(@"did update events");
    content = [DataController getEvents];
    [[self tableView] reloadData];
    [refresh endRefreshing];
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


- (IBAction)swipe:(id)sender {
    
    
    [[self tabBarController] setSelectedViewController:[[[self tabBarController] viewControllers]objectAtIndex:0]];  
}

- (IBAction)swipeLeft:(id)sender {
    [[self tabBarController] setSelectedViewController:[[[self tabBarController] viewControllers]objectAtIndex:2]];
}
@end
