//
//  MessagesViewController.h
//  ccm
//
//  Created by Brenton Durkee on 7/30/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constaints.h"
#import "DataController.h"
#import "Messages.h"
#import "MessagesTableViewCell.h"
#import "MessageDetailViewController.h"

@interface MessagesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property NSArray *content;

@property NSIndexPath *selectedRow;

@end
