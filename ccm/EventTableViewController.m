//
//  EventTableViewController.m
//  ccm
//
//  Created by Brenton Durkee on 8/2/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

#import "EventTableViewController.h"

@interface EventTableViewController ()

@end

@implementation EventTableViewController

@synthesize data;
@synthesize timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    [self setTitle:[data name]];
    [[self time] setText:[DateUtil stringFromDateTil:[data date]]];
    
    [[self desc] setText:[data desc]];
    
}

-(void) viewWillAppear:(BOOL)animated  {
//    [[self map] setCenterCoordinate:[CLLocationCoordinate2DMake([[data lat] doubleValue], [[data lng] doubleValue])]];
    CLLocationDegrees lat = [[data lat] doubleValue];
    CLLocationDegrees lng = [[data lng] doubleValue];
    CLLocationCoordinate2D cord = {lat, lng};
    MKCoordinateSpan span = {.005, 0};
    MKCoordinateRegion region = {cord, span};
    [[self map] setRegion:region];
    
    MKPointAnnotation *ann = [[MKPointAnnotation alloc] init];
    [ann setCoordinate:cord];
    [ann setTitle:[data location]];
    [[self map] addAnnotation:ann];
    _annonation = ann;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
    
//    NSLog(@"%@", [data lat]);
}

-(void) viewDidDisappear:(BOOL)animated{
    [timer invalidate];
}

-(void)updateCounter:(NSTimer *)timer{
    [[self time] setText:[DateUtil stringFromDateTil:[data date]]];

}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MKPinAnnotationView *customPin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"LocPin"];
    customPin.pinColor = MKPinAnnotationColorRed;
    customPin.canShowCallout = YES;
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [right addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    customPin.rightCalloutAccessoryView = right;
    
    return customPin;
    
}

- (void)mapView:(MKMapView *)mapView
  annotationView:(MKAnnotationView *)view
calloutAccessoryControlTapped:(UIControl *)control {
    NSString *query;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]){
//        query = [NSString stringWithFormat:@"comgooglemaps://?q=%@&center=%@,%@", [data address],[data lat], [data lng]];
        query = [query stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:query]];
    }
    else {
        id <MKAnnotation> annon = [view annotation];
        MKPlacemark *place = [[MKPlacemark alloc] initWithCoordinate:[annon coordinate]  addressDictionary: nil ];
        MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:place];
        [item setName:[annon title]];
    //    [item openInMapsWithLaunchOptions:nil];
        [item openInMapsWithLaunchOptions:[NSDictionary dictionaryWithObjectsAndKeys:MKLaunchOptionsDirectionsModeWalking, MKLaunchOptionsDirectionsModeKey, nil]];
    }
}

-(void) mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    [mapView selectAnnotation:_annonation animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 3;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
