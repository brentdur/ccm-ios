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
@synthesize sections;
@synthesize splits;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    content = [DataController getMessages];
    sections = [DataController getTopics];
    if([content count] == 0){
        [DataController setDelegate:self withType:ENTITY_MESSAGES];
    }
    [self sectionize];
    
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
    sections = [DataController getTopics];
    [self sectionize];
    [[self tableView] reloadData];
    [refresh endRefreshing];
}

-(void) sectionize{
    NSMutableDictionary *stuff = [[NSMutableDictionary alloc] init];
    NSMutableArray *messages = [[NSMutableArray alloc] initWithArray:content];
    for (Topics* topic in sections){
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSMutableArray *deletes = [[NSMutableArray alloc] init];
        for (Messages* message in messages){
            if ([[topic getIdd]isEqualToString: [message topic]]){
                [array addObject:message];
                [deletes addObject:message];
            }
        }
        [messages removeObjectsInArray:deletes];
        [stuff setValue:array forKey:[topic name]];
//        NSLog(@"%@", stuff);
    }
    splits = stuff;
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
    NSArray *array = (NSArray *)[splits valueForKey:[[sections objectAtIndex:section] name]];
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellMsg";
    
    MessagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [[MessagesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    Messages *msg = [[splits valueForKey:[[sections objectAtIndex:indexPath.section] name]] objectAtIndex:indexPath.row];
    cell.label1.text = [msg subject];
    cell.label2.text = @"";
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [sections count];
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[sections objectAtIndex:section] name];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setSelectedRow:indexPath];
//    MessageDetailViewController *dv = [[self storyboard] instantiateViewControllerWithIdentifier:@"MsgDetail"];
//    [[self navigationController] pushViewController:dv animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"MsgDetail" sender:self];

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [[sections objectAtIndex:[indexPath section]] name];
    NSLog(@"%@", key);
    NSArray *array = (NSArray *)[splits objectForKey:key];
    NSLog(@"%@", array);
    NSDictionary *data = @{@"message": [[array objectAtIndex:[indexPath row]] getIdd]};;
    NSLog(@"%@", data);
    [[self view] makeToastActivity];
    [DataController deleteMsg:data andHandler:^(NSMutableArray *data, NSError *error) {
        [[self view] hideToastActivity];
        if (error){
            NSLog(@"error");
        }
        else {
            NSMutableDictionary *spli = [[NSMutableDictionary alloc] initWithDictionary:splits];
            NSMutableArray *cont = [[NSMutableArray alloc] initWithArray:array];
            [cont removeObjectAtIndex:indexPath.row];
            [spli setObject:cont forKey:key];
            splits = spli;
            [tableView reloadData];
        }
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"MsgDetail"]) {
        MsgTableViewController *detailViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self selectedRow];
        Messages *msg = [[splits valueForKey:[[sections objectAtIndex:indexPath.section] name]] objectAtIndex:indexPath.row];
        [detailViewController setData: msg];
    }
}


- (IBAction)swipeLeft:(id)sender {
    [[self tabBarController] setSelectedViewController:[[[self tabBarController] viewControllers]objectAtIndex:1]];
}

- (IBAction)edit:(id)sender {
    if ([[self tableView] isEditing]){
        [[self tableView] setEditing:NO];
        [[self editButton] setTitle:@"Edit"];
    }
    else {
        [[self editButton] setTitle:@"Done"];
        [[self tableView] setEditing:YES];
    }
    
}
@end
