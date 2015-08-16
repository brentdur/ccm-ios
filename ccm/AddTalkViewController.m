//
//  AddTalkViewController.m
//  ccm
//
//  Created by Brenton Durkee on 8/5/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "AddTalkViewController.h"

@interface AddTalkViewController ()

@end

@implementation AddTalkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [[self fieldLabel] setHidden:YES];
}

- (void) textViewDidEndEditing:(UITextView *)textView {
    if([[textView text] isEqualToString:@""]){
        [[self fieldLabel] setHidden:NO];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)done:(id)sender {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setValue:[[self subjectField] text] forKey:@"subject"];
    [data setValue:[[self dateField] text] forKey:@"date"];
    [data setValue:[[self authorField] text] forKey:@"author"];
    [data setValue:[[self refField] text] forKey:@"reference"];
    
    NSCharacterSet *seperator = [NSCharacterSet newlineCharacterSet];
    NSArray *lines = [[[self textView] text] componentsSeparatedByCharactersInSet:seperator];
    [data setValue:lines forKey:@"outline"];
//    for (NSString *line in lines){
//        [data setValue:line forKey:@"outline"];
//    }

    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:data];
    
    [[self view] makeToastActivity];
    [DataController addTalkWithData:dic andHandler:^(NSMutableArray *data, NSError *error) {
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
