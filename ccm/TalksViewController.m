//
//  TalksViewController.m
//  ccm
//
//  Created by Brenton Durkee on 8/1/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "TalksViewController.h"

@interface TalksViewController ()

@end

@implementation TalksViewController

@synthesize content;
@synthesize refresh;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"talks did load");
    content = [DataController getTalks];
    if([content count] == 0){
        [DataController setDelegate:self withType:ENTITY_TALKS];
    }
    
    MainTabViewController *parent = (MainTabViewController *)[self tabBarController];
    if(![parent canWriteTalks]){
        [[self bar] setRightBarButtonItem:nil];
    }
    UIBarButtonItem *left = [UIBarButtonItem alloc];
    if([parent isMinister]){
        left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(inbox:)];
    }
    else {
        left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(sendMsg:)];
    }
    [[self bar] setLeftBarButtonItem:left];
    [refresh addTarget:self action:@selector(refreshStuff) forControlEvents:UIControlEventValueChanged];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [[[self tabBarController] tabBar] setHidden:NO];
    if ([content count] != [DataController getNumTalks]){
        [self didUpdateData];
    }
}

-(void) refreshStuff{
    NSLog(@"refresh");
    [DataController setDelegate:self withType:ENTITY_TALKS];
    [DataController sync];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) didUpdateData{
    NSLog(@"did update talks");
    content = [DataController getTalks];
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
    return [content count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellTalk";
    
    TalksTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [[TalksTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.label1.text = [(Talks *)content[indexPath.row] subject];
    cell.label2.text = [DateUtil eventLittleString:[(Talks *)content[indexPath.row] date]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setSelectedRow:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"TalkDetail" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"TalkDetail"]) {
        TalkTableViewController *detailViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self selectedRow];
        [detailViewController setData:(Talks *) content[indexPath.row]];
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

@end
