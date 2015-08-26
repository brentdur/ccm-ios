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

id<PermissionSetDelegate> del;
bool done;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *dics = [[NSUserDefaults standardUserDefaults] arrayForKey:KEY_GROUPS];
    if (!dics){
        [DataController setGroupDelegate:self];
        [DataController saveMyGroup];
    }
    else {
        [self didUpdateData];
    }
    [self setSelectedViewController:[[self viewControllers] objectAtIndex:1]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) didUpdateData {
    [self setCanWriteEvents:false];
    [self setCanWriteSignups: false];
    [self setCanWriteTalks: false];
    [self setIsMinister:false];
    [self setLoaded:false];
    NSArray *dics = [[NSUserDefaults standardUserDefaults] arrayForKey:KEY_GROUPS];
    NSLog(@"%@", dics);
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
        if([(NSString *)[group valueForKey:@"name"] isEqualToString:@"ministers"]){
            [self setIsMinister:true];
        }
    }
    [self setLoaded:YES];
    done = true;
    if (del){
        [del permissionsSet];
    }
    //TODO: get tab controller to hide nav buttons
    NSLog(@"%d %d %d", _canWriteEvents, _canWriteSignups, _canWriteTalks);
    
}

-(void) setTheDelegate:(id<PermissionSetDelegate>)delegate {
    if (done){
        [delegate permissionsSet];
    }
    else {
        del = delegate;
    }
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
