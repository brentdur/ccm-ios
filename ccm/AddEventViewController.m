//
//  AddEventViewController.m
//  ccm
//
//  Created by Brenton Durkee on 8/5/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "AddEventViewController.h"

@interface AddEventViewController ()

@end

@implementation AddEventViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLocData:[DataController getLocations]];
    [self setLocName:[[[self locData] objectAtIndex:0] name ]];
    
    
    
    [self setInsertTableViewRowAnimation:UITableViewRowAnimationFade];
    [self setDeleteTableViewRowAnimation:UITableViewRowAnimationFade];
    [self setReloadTableViewRowAnimation:UITableViewRowAnimationFade];
    
    [self hideCellanimated:NO hidden:YES];
    
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
        [data setValue:[[self locNameField] text] forKey:@"location"];
        [data setValue:[[self locAddField] text] forKey:@"address"];
    }
    else {
        [data setValue:[self locName] forKey:@"location"];
    }
    [data setValue:[[self titleField] text] forKey:@"title"];
    [data setValue:[[self dateField] text] forKey:@"date"];
    [data setValue:[[self textView] text] forKey:@"description"];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:data];
    NSLog(@"%@", dic);
    [DataController addEventWithData:dic];
    
}
@end
