//
//  SignInViewController.h
//  ccm
//
//  Created by Brenton Durkee on 7/27/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdminRequest.h"
#import "Constaints.h"
#import "KeychainItemWrapper.h"
#import "DataController.h"


@interface SignInViewController : UIViewController <AdminRequestDelegate>

@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property UIViewController *runningView;
- (IBAction)signin:(id)sender;
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (IBAction)done:(id)sender;
@end
