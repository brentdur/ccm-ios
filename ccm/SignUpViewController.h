//
//  SignUpViewController.h
//  ccm
//
//  Created by Brenton Durkee on 7/27/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdminRequest.h"
#import "Constaints.h"
#import "KeychainItemWrapper.h"
#import "SignInViewController.h"
#import "UIView+Toast.h"

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)signup:(id)sender;
- (IBAction)done:(id)sender;

@end
