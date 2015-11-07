//
//  MultiSelectViewController.h
//  RUF City Campus
//
//  Created by Brenton Durkee on 11/5/15.
//  Copyright © 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultiSelectCell.h"

@interface MultiSelectViewController : UITableViewController <CellClickedDelegate>

@property NSArray *data;
@property NSMutableArray *selections;

-(void) buttonTapped:(NSString *) text;

-(void) buttonUnTapped:(NSString *) text;

@end
