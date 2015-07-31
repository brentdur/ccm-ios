//
//  FirstViewController.h
//  ccm
//
//  Created by Brenton Durkee on 7/27/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constaints.h"
#import "KeychainItemWrapper.h"
#import "DataController.h"

@interface FirstViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *label;
- (IBAction)touch:(id)sender;
- (IBAction)get:(id)sender;


@end

