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
    
    //test if user has token already
    NSString *testEmail =[[NSUserDefaults standardUserDefaults] objectForKey:KEY_EMAIL];
    
    

    if (testEmail) {
        [_email setText:testEmail];
    }
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

*/

-(IBAction)signin:(id)sender {
    //get email/password, send to AdminRequest, reference self as delegate
    NSString *email = [_email text];
    NSString *password = [_password text];
    NSLog(@"%@ %@", email, password);
    if (email.length != 0 && password.length != 0){
        NSDictionary *dic = @{
                              @"email": email,
                              @"password": password
                              };
        NSLog(@"%@", dic);
        [[self view] makeToastActivity];
        _runningView = self;
        [DataController signIn:dic andHandler:^(NSMutableArray *data, NSError *error) {
            [self postReturn:data andError:error];
        }];
//        [[AdminRequest sharedInstance] signInEmail:email andPassword:password andDelegate:self];
    }
}

//recieves the delgate return
- (void)adminRequest:(AdminRequest *)adminRequest didReturnData:(id)data {
    NSLog(@"Delegated: %@", data);
    
    [KeychainItemWrapper save:KEYCHAIN_KEY_TOKEN data:data];
    //if success
    [[NSUserDefaults standardUserDefaults] setBool:true forKey:KEY_HAS_TOKEN];
    [[NSUserDefaults standardUserDefaults] setObject:[_email text] forKey:KEY_EMAIL];
    [DataController sync];
    [self goToTabView];
    
}

-(void) postReturn:(NSMutableArray *) data andError:(NSError *) error{
    [[_runningView view] hideToastActivity];
    if (error){
        [[_runningView view] makeToast:@"Login Failed" duration:3.0 position:CSToastPositionLower];
    }
    else {
        NSLog(@"return: %@", [data valueForKey:@"token"]);
        [KeychainItemWrapper save:KEYCHAIN_KEY_TOKEN data:[data valueForKey:@"token"]];
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:KEY_HAS_TOKEN];
        [[NSUserDefaults standardUserDefaults] setObject:[_email text] forKey:KEY_EMAIL];
        [DataController sync];
        [self goToTabView];
    }
}

//switch to tab view, close navbar view
-(void) goToTabView {
    UIViewController *cont = [_runningView.storyboard instantiateViewControllerWithIdentifier:@"TabView"];
    [_runningView presentViewController:cont animated:true completion:nil];
    [_runningView removeFromParentViewController];
}

//allows signup view cont to unwind back using the nav controller
-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
    
}

//handles return key-press
- (IBAction)done:(id)sender {
    [self signin:sender];
}
@end
