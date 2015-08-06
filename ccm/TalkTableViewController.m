//
//  TalkTableViewController.m
//  ccm
//
//  Created by Brenton Durkee on 8/2/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "TalkTableViewController.h"

@interface TalkTableViewController ()

@end

@implementation TalkTableViewController

@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self setTitle:[data subject]];
    [[self author] setText:[data author]];
    [[self date] setText:[DateUtil stringFromDate:[data date]]];
    [[self ref] setText:[data reference]];
    [[self fillRef] setText:[data fullVerse]];
    [[self outline] setText:[data outline]];
    
    [self setInsertTableViewRowAnimation:UITableViewRowAnimationFade];
    [self setDeleteTableViewRowAnimation:UITableViewRowAnimationFade];
    [self setReloadTableViewRowAnimation:UITableViewRowAnimationFade];
    
    [self toggleCell:[self fullRefCell] animated:false];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

- (IBAction)refTap:(id)sender {
    [self toggleCell:[self fullRefCell] animated:true];
}

-(void)toggleCell:(UITableViewCell *)cell animated:(BOOL) anim{
    _cellHidden = !_cellHidden;
    [self setHideSectionsWithHiddenRows:anim];
    [self cell:cell setHidden:_cellHidden];
    [self reloadDataAnimated:anim];
    [[self fillRef] setContentOffset:CGPointZero];
}
@end
