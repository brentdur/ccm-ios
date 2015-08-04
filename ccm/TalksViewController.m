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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    content = [DataController getTalks];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    cell.label2.text = [(Talks *)content[indexPath.row] author];
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


- (IBAction)swipeRight:(id)sender {
    [[self tabBarController] setSelectedViewController:[[[self tabBarController] viewControllers]objectAtIndex:1]];
}
@end
