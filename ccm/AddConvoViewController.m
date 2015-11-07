//
//  AddConvoViewController.m
//  RUF City Campus
//
//  Created by Brenton Durkee on 11/5/15.
//  Copyright © 2015 Brenton Durkee. All rights reserved.
//

#import "AddConvoViewController.h"

@implementation AddConvoViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    
    [self setTopicData:[DataController getTopics]];
    [self setTopicId:[[[self topicData] objectAtIndex:0] getIdd]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[[self topicData] objectAtIndex:row] name];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [[self topicData] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView accessibilityLabelForComponent:(NSInteger)component
{
    return @"Topics";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self setTopicId:[[[self topicData] objectAtIndex:row]getIdd]];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    [[self fieldLabel] setHidden:YES];
}

-(void)textViewDidEndEditing:(UITextView *) textView{
    if([[textView text] isEqualToString:@""]){
        [[self fieldLabel] setHidden:NO];
    }
}

- (IBAction)done:(id)sender {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setValue:_subjectField.text forKey:@"subject"];
    [data setValue:_textView.text forKey:@"message"];
    [data setValue:_topicId forKey:@"topic"];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:data];
    [[self view] makeToastActivity];
    [DataController addConvoWithData:dic andHandler:^(NSMutableArray *data, NSError *error) {
        [[self view] hideToastActivity];
        if (error) {
            [[[self parentViewController] view] makeToast:@"Error" duration:3.0 position:CSToastPositionLower];
        }
        else {
            [[[self parentViewController] view] makeToast:@"Success" duration:3.0 position:CSToastPositionLower];
            [[self navigationController] popViewControllerAnimated:YES];
        }
    }];
}

@end
