//
//  SignupsViewController.m
//  ccm
//
//  Created by Brenton Durkee on 8/10/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "SignupsViewController.h"

@interface SignupsViewController ()

@end

@implementation SignupsViewController

@synthesize content;
@synthesize refresh;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"signups did load");
    
    content = [DataController getSignups];
    if ([content count] == 0) {
        [DataController setDelegate:self withType:ENTITY_SIGNUPS];
    }
    
    MainTabViewController *parent = (MainTabViewController *)[self tabBarController];
    if(![parent canWriteSignups]){
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
    UINavigationBar *navBar = [[self navigationController] navigationBar];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tripleTap)];
    [recognizer setNumberOfTapsRequired:6];
    [navBar addGestureRecognizer:recognizer];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [[[self tabBarController] tabBar] setHidden:NO];
    [[self tableView]reloadData];
    if ([content count] != [DataController getNumSignups]){
        [self didUpdateData];
    }
}

-(void) refreshStuff{
    NSLog(@"refresh");
    [DataController setDelegate:self withType:ENTITY_SIGNUPS];
    [DataController sync];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didUpdateData{
    NSLog(@"did update signups");
    content = [DataController getSignups];
    [[self tableView] reloadData];
    [refresh endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [content count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellSignup";
    
    SignupsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil){
        cell = [[SignupsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.label1.text = [(Signups *) content[indexPath.row] name];
    cell.label2.text = [NSString stringWithFormat:@"%@", [(Signups *) content[indexPath.row] memberCount]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self setSelectedRow:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"SignupDetail" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"SignupDetail"]) {
        SignupTableViewController *detailViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self selectedRow];
        [detailViewController setData:(Signups *) content[indexPath.row]];
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

- (void) tripleTap {
    NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
    [pref setObject:NULL forKey:KEY_GROUPS];
    
    [pref setBool:false forKey:KEY_HAS_TOKEN];
    
    UIViewController *cont = [[self storyboard]instantiateInitialViewController];
    [self presentViewController:cont animated:true completion:nil];
    [[self tabBarController] removeFromParentViewController];
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
