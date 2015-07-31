//
//  FirstViewController.m
//  ccm
//
//  Created by Brenton Durkee on 7/27/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touch:(id)sender {
    NSLog(@"Events");
    for (Events *event in[DataController getEvents]){
        NSLog(@"%@", event);
    }
    NSLog(@"Messages");
    for (Messages *message in[DataController getMessages]){
        NSLog(@"%@", message);
    }
    NSLog(@"Talks");
    for (Talks *talk in[DataController getTalks]){
        NSLog(@"%@", talk);
    }
    NSLog(@"Groups");
    for (Groups *group in[DataController getGroups]){
        NSLog(@"%@", group);
    }
    NSLog(@"Locations");
    for (Locations *loc in[DataController getLocations]){
        NSLog(@"%@", loc);
    }
}

- (IBAction)get:(id)sender {
    [DataController sync];

    
    
}
@end
