//
//  AddSignupViewController.m
//  ccm
//
//  Created by Brenton Durkee on 8/10/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "AddSignupViewController.h"

@interface AddSignupViewController ()

@end

@implementation AddSignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLocData:[DataController getLocations]];
    [self setLocName:[[[self locData] objectAtIndex:0] name]];
    
    [self setInsertTableViewRowAnimation:UITableViewRowAnimationFade];
    [self setDeleteTableViewRowAnimation:UITableViewRowAnimationFade];
    [self setReloadTableViewRowAnimation:UITableViewRowAnimationFade];
    
    [self hideCellanimated:NO hidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [[self textLabel] setHidden:YES];
}

- (void) textViewDidEndEditing:(UITextView *)textView {
    if([[textView text] isEqualToString:@""]){
        [[self textLabel] setHidden:NO];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ( row == [[self locData] count]){
        return @"Other";
    }
    return [[[self locData] objectAtIndex:row] name];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [[self locData] count] + 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (row == [[self locData] count]){
        NSLog(@"other");
        [self hideCellanimated:YES hidden:NO];
        self.locName = @"Other";
    }
    else {
        
        [self hideCellanimated:YES hidden:YES];
        self.locName = [[[self locData] objectAtIndex:row]name];
    }
    
    
}

-(void)hideCellanimated:(BOOL) anim hidden:(BOOL) hide{
    [self setHideSectionsWithHiddenRows:anim];
    [self cell:[self cell] setHidden:hide];
    [self cell:[self cell2] setHidden:hide];
    [self reloadDataAnimated:anim];
}



- (IBAction)done:(id)sender {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    if ([[self locName] isEqualToString:@"Other"]){
        [data setValue:[[self locationNameField] text] forKey:@"location"];
        [data setValue:[[self address] text] forKey:@"address"];
    }
    else {
        [data setValue:[self locName] forKey:@"location"];
    }
    [data setValue:[[self name] text] forKey:@"name"];
    [data setValue:[[self dateInfo] text] forKey:@"dateInfo"];
    [data setValue:[[self textView] text] forKey:@"description"];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:data];
    NSLog(@"%@", dic);
    [[self view] makeToastActivity];
    [DataController addSignupWithData:dic andHandler:^(NSMutableArray *data, NSError *error) {
        [[self view] hideToastActivity];
        if (error){
            [[[self parentViewController] view] makeToast:@"Error" duration:3.0 position:CSToastPositionLower];
        }
        else {
            [[[self parentViewController] view] makeToast:@"Success" duration:3.0 position:CSToastPositionLower];
            [[self navigationController] popViewControllerAnimated:YES];
        }
    }];

}
@end
