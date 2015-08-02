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

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    content = [DataController getEvents];
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
    static NSString *cellId = @"Cell";
    
    EventsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        cell = [[EventsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.label1.text = [(Events *)content[indexPath.row] name];
    cell.label2.text = [(Events *)content[indexPath.row] location];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setSelectedRow:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"EventDetail" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"MsgDetail"]) {
        EventDetailViewController *detailViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self selectedRow];
        [detailViewController setData:(Events *) content[indexPath.row]];
    }
}

@end
