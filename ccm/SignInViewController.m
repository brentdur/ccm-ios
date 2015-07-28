//
//  SignInViewController.m
//  ccm
//
//  Created by Brenton Durkee on 7/27/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

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

- (IBAction)signin:(id)sender {
    NSString *email = [_email text];
    NSString *password = [_password text];
    NSLog(@"%@ %@", email, password);
//    [[AdminRequest sharedInstance] signInEmail:email andPassword:password andDelegate:self];
    [self performSegueWithIdentifier:@"Segue1" sender:sender];
}

- (void)adminRequest:(AdminRequest *)adminRequest didReturnData:(id)data {
    NSLog(@"Delegated: %@", data);
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"Segue1"]){
        NSLog(@"hi");
    }
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
    
}

@end
