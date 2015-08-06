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
    
    [self setGroupData:[DataController getGroups]];
    [self setGroupName:[[[self groupData] objectAtIndex:0]name]];
    
    self.textView.layer.borderWidth = .5f;
    self.textView.layer.cornerRadius = 10.0f;
    self.textView.layer.borderColor = [[UIColor lightGrayColor] CGColor];

    
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
    return [[[self groupData] objectAtIndex:row] name];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [[self groupData] count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self setGroupName:[[[self groupData] objectAtIndex:row]name]];
}


- (IBAction)done:(id)sender {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setValue:[[self subjectField] text] forKey:@"subject"];
    [data setValue:[[self messageField] text] forKey:@"message"];
    [data setValue:[self groupName] forKey:@"to"];
    [data setValue:@"test" forKey:@"from"];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:data];
    NSLog(@"%@", dic);
    [DataController addMsgWithData:dic];
}
@end
