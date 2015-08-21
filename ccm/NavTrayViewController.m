//
//  NavTrayViewController.m
//  ccm
//
//  Created by Brenton Durkee on 8/5/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "NavTrayViewController.h"

@interface NavTrayViewController ()

@end

@implementation NavTrayViewController

@synthesize currentID;
@synthesize rvc;
@synthesize inboxEnabled;
@synthesize sendEnabled;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setInsertTableViewRowAnimation:UITableViewRowAnimationFade];
    [self setDeleteTableViewRowAnimation:UITableViewRowAnimationFade];
    [self setReloadTableViewRowAnimation:UITableViewRowAnimationFade];
    
    
    NSArray *dics = [[NSUserDefaults standardUserDefaults] arrayForKey:KEY_GROUPS];
    sendEnabled = true;
    inboxEnabled = false;
    for (NSDictionary *group in dics){
        NSLog(@"%@", [group valueForKey:@"name"]);
        if ([[group valueForKey:@"name"] isEqualToString:@"ministers"]){
            inboxEnabled = true;
            sendEnabled = false;
            break;
        }
    }

    [self toggleCellsWithAnimation:false];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)toggleCellsWithAnimation:(BOOL) anim{
    [self setHideSectionsWithHiddenRows:anim];
    
    [self cell:[self inboxCell] setHidden:!inboxEnabled];
    [self cell:[self sendCell] setHidden:!sendEnabled];
    
    [self cell:[self homeCell] setHidden:NO];
    
    if([currentID isEqualToString:@"TabView"]){
        [self cell:[self homeCell] setHidden:YES];
    }
    else if ([currentID isEqualToString:@"Inbox"]){
        [self cell:[self inboxCell] setHidden:YES];
    }
    else if ([currentID isEqualToString:@"SendMsg"]){
        [self cell:[self sendCell] setHidden:YES];
    }
    
    [self reloadDataAnimated:anim];
}
@end
