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
    
    self.textView.layer.borderWidth = .5f;
    self.textView.layer.cornerRadius = 10.0f;
    self.textView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
