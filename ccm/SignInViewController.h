//
//  SignInViewController.h
//  ccm
//
//  Created by Brenton Durkee on 7/27/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdminRequest.h"

@interface SignInViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)signin:(id)sender;
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
@end
