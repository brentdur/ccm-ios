//
//  TalksViewController.h
//  ccm
//
//  Created by Brenton Durkee on 8/1/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constaints.h"
#import "DataController.h"
#import "Talks.h"
#import "TalksTableViewCell.h"
#import "TalkDetailViewController.h"

@interface TalksViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property NSArray *content;

@property NSIndexPath *selectedRow;

@end
