//
//  MainTabViewController.m
//  ccm
//
//  Created by Brenton Durkee on 8/2/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "MainTabViewController.h"

@interface MainTabViewController ()

@end

@implementation MainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCanWriteEvents:false];
    [self setCanWriteSignups: false];
    [self setCanWriteTalks: false];
    NSArray *dics = [[NSUserDefaults standardUserDefaults] arrayForKey:KEY_GROUPS];
    for (NSDictionary *group in dics){
        if ([(NSNumber *)[group valueForKey:@"writeSignups"] isEqualToNumber:@1]){
            [self setCanWriteSignups:true];
        }
        if([(NSNumber *)[group valueForKey:@"writeEvents"] isEqualToNumber:@1]){
            [self setCanWriteEvents:true];
        }
        if([(NSNumber *)[group valueForKey:@"writeTalks"] isEqualToNumber:@1]){
            [self setCanWriteTalks:true];
        }
    }
    NSLog(@"%d %d %d", _canWriteEvents, _canWriteSignups, _canWriteTalks);
    [self setSelectedViewController:[[self viewControllers] objectAtIndex:1]];
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

@end
