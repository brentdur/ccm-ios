//
//  MessagesViewController.m
//  ccm
//
//  Created by Brenton Durkee on 7/30/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "MessagesViewController.h"

//TODO rewrite all of this to support convo, bc, and the addition of bc

@interface MessagesViewController ()

@end

@implementation MessagesViewController

@synthesize broadcastContent;
@synthesize convoContent;
@synthesize selectedRow;
@synthesize refresh;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    broadcastContent = [DataController getBroadcasts];
    convoContent = [DataController getConvos];
    
    //TODO add observer logic
    
    [refresh addTarget:self action:@selector(refreshStuff) forControlEvents:UIControlEventValueChanged];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void) refreshStuff{
    NSLog(@"refresh");
    [DataController setDelegate:self withType:ENTITY_BROADCAST];
    [DataController setDelegate:self withType:ENTITY_CONVO];
    [DataController sync];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) didUpdateData{
    NSLog(@"did update convos/bcs");
    broadcastContent = [DataController getBroadcasts];
    convoContent = [DataController getConvos];
    [[self tableView] reloadData];
    [refresh endRefreshing];
}

//-(void) sectionize{
//    //TODO, won't need this anymore
//    NSMutableDictionary *stuff = [[NSMutableDictionary alloc] init];
//    NSMutableArray *messages = [[NSMutableArray alloc] initWithArray:content];
//    for (Topics* topic in sections){
//        NSMutableArray *array = [[NSMutableArray alloc] init];
//        NSMutableArray *deletes = [[NSMutableArray alloc] init];
//        for (Messages* message in messages){
//            if ([[topic getIdd]isEqualToString: [message topic]]){
//                [array addObject:message];
//                [deletes addObject:message];
//            }
//        }
//        [messages removeObjectsInArray:deletes];
//        [stuff setValue:array forKey:[topic name]];
////        NSLog(@"%@", stuff);
//    }
//    splits = stuff;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return broadcastContent.count + convoContent.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellInbox";
    InboxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[InboxTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    if (indexPath.row < broadcastContent.count) {
        //do a broadcast
        Broadcasts *bc = [broadcastContent objectAtIndex:indexPath.row];
        cell.label1.text = [bc title];
        cell.label2.text = @"";
    }
    else {
        //do a convo
        Conversations *convo = [convoContent objectAtIndex:indexPath.row];
        cell.label1.text = [convo subject];
        cell.label2.text = [convo from_who];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setSelectedRow:indexPath];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //TODO change segue id
    if (indexPath.row < broadcastContent.count) {
        [self performSegueWithIdentifier:@"MsgDetail" sender:self];
        //its a bc
    }
    else {
        [self performSegueWithIdentifier:@"MsgDetail" sender:self];
        //its a convo
    }
    
    

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self view] makeToastActivity];
    if (indexPath.row < broadcastContent.count) {
        //do a broadcast
        NSDictionary *data = @{@"cast": [[broadcastContent objectAtIndex:[indexPath row]] getIdd]};
        [DataController putKillBC:data andHandler:^(NSMutableArray *data, NSError *error) {
            [[self view] hideToastActivity];
            if (error){
                NSLog(@"error");
            }
            else {
                NSMutableArray *array = [[NSMutableArray alloc] initWithArray:broadcastContent];
                [array removeObjectAtIndex:indexPath.row];
                broadcastContent = array;
                [tableView reloadData];
            }
        }];
    }
    else {
        //do a convo
        NSDictionary *data = @{@"conversation": [[convoContent objectAtIndex:[indexPath row]] getIdd]};
        [DataController putKillConvo:data andHandler:^(NSMutableArray *data, NSError *error) {
            [[self view] hideToastActivity];
            if (error){
                NSLog(@"error");
            }
            else {
                NSMutableArray *array = [[NSMutableArray alloc] initWithArray:convoContent];
                [array removeObjectAtIndex:indexPath.row];
                convoContent = array;
                [tableView reloadData];
            }
        }];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //TODO update with correct segues
    if (indexPath.row < broadcastContent.count) {
        [self performSegueWithIdentifier:@"MsgDetail" sender:self];
        //its a bc
    }
    else {
        [self performSegueWithIdentifier:@"MsgDetail" sender:self];
        //its a convo
    }
    
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
