//
//  SignUpViewController.m
//  ccm
//
//  Created by Brenton Durkee on 7/27/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "SignUpViewController.h"
@class SignInViewController;

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)signup:(id)sender {
    NSString *name = [_name text];
    NSString *email = [_email text];
    NSString *password = [_password text];
    
    if (email && password && name){
        SignInViewController *signin = [[SignInViewController alloc] init];
        [signin setEmail:_email];
        [[AdminRequest sharedInstance] signUpName:name forEmail:email andPassword:password andDelegate:signin];
        [signin setRunningView:self];
    }
}

-(IBAction)done:(id)sender {
    [self signup:sender];
}

@end