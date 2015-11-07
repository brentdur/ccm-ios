//
//  MultiSelectCell.m
//  RUF City Campus
//
//  Created by Brenton Durkee on 11/5/15.
//  Copyright © 2015 Brenton Durkee. All rights reserved.
//

#import "MultiSelectCell.h"

@implementation MultiSelectCell

static id <CellClickedDelegate> delegate;

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDelegate:(id)del {
    delegate = del;
}

- (IBAction)buttonPressed:(id)sender {
    if ([[self button] isEnabled]) {
        [delegate buttonTapped:[[self button] titleForState:UIControlStateNormal]];
        [[self button] setEnabled:false];
    }
    else {
        [delegate buttonUnTapped:[[self button] titleForState:UIControlStateNormal]];
        [[self button] setEnabled:true];
    }
}
@end
