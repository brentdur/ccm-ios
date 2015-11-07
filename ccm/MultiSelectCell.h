//
//  MultiSelectCell.h
//  RUF City Campus
//
//  Created by Brenton Durkee on 11/5/15.
//  Copyright © 2015 Brenton Durkee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultiSelectCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIButton *button;
- (IBAction)buttonPressed:(id)sender;

- (void) setDelegate:(id) del;

@end

@protocol CellClickedDelegate

@optional

-(void) buttonTapped:(NSString *) text;

-(void) buttonUnTapped:(NSString *) text;

@end
