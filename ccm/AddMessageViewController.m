//
//  AddMessageViewController.m
//  ccm
//
//  Created by Brenton Durkee on 8/5/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "AddMessageViewController.h"

@interface AddMessageViewController ()

@end

@implementation AddMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self setGroupData:[DataController getGroups]];
//    [self setGroupName:[[[self groupData] objectAtIndex:0]name]];
    
    [self setTopicData:[DataController getTopics]];
    [self setTopicId:[[[self topicData] objectAtIndex:0] getIdd]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    [data setValue:[[self subjectField] text] forKey:@"subject"];
    [data setValue:[[self textView] text] forKey:@"message"];
    [data setValue:[self topicId] forKey:@"topic"];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:data];
    NSLog(@"%@", dic);
    [DataController addMsgWithData:dic andHandler:^(NSMutableArray *data, NSError *error) {
        NavTrayViewController *nav = (NavTrayViewController *)[[self revealViewController] rearViewController];
        if (error){
            [[nav view] makeToast:@"Sent" duration:3.0 position:CSToastPositionLower];
        }
        else {
            [[[nav parentViewController] view] makeToast:@"Sent" duration:3.0 position:CSToastPositionLower];
            [[self navigationController] popViewControllerAnimated:YES];
        }
    }];
}
@end
