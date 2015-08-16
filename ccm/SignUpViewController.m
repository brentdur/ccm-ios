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
    if (email.length != 0 && password.length != 0 && name.length != 0){
        SignInViewController *signin = [[[self navigationController] viewControllers] objectAtIndex:0];
        [signin setEmail:_email];
        NSDictionary *dic = @{
                              @"name": name,
                              @"email": email,
                              @"password": password
                              };
        NSLog(@"%@", dic);
        [[self view] makeToastActivity];
        [signin setRunningView:self];
        [DataController signUp:dic andHandler:^(NSMutableArray *data, NSError *error) {
            [signin postReturn:data andError:error];
        }];
    }
}

-(IBAction)done:(id)sender {
    [self signup:sender];
}

@end
