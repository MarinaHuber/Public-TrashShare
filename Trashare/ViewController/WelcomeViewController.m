//
//  WelcomeViewController.m
//  Trashare
//
//  Created by Marina Huber on 11/2/15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@end


@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.mapView setShowsUserLocation:YES];
    
	PFObject *trash = [PFObject objectWithClassName:@"test"];
	trash[@"titleTrash"] = @"aaaloha";
	[trash saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
		if (succeeded) {
			NSLog(@"UPLOAD ITEMS TRASH TITLE: %@", trash);
		} else {
			NSLog(@"PROOOOBLEM");
		}
	}];
    self.navigationController.navigationBarHidden = YES;
    
}
// shows map location
- (IBAction)authorizationButton:(id)sender {
    
    HomeViewController *map = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:map animated:YES];
    
    // Create location manager object
    self.locationManager = [[CLLocationManager alloc] init];
    self.mapView.delegate = self;
    
    // There will be a warning from this line of code; ignore it for now
    [self.locationManager setDelegate:self];
    
    // And we want it to be as accurate as possible
    // regardless of how much time/power it takes
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    // Tell our manager to start looking for its location immediately
    [self.locationManager startUpdatingLocation];
    
    [self.locationManager requestWhenInUseAuthorization];
	[self.locationManager requestAlwaysAuthorization];
   
    
   CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    
    if (
     authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
      authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
       
        [self.locationManager startUpdatingLocation];
    
    }
}

////this needed for storing location do get user location from this method instead of MKUserLocation
- (void)locationManager:(CLLocationManager * _Nonnull)manager
     didUpdateLocations:(NSArray<CLLocation *> * _Nonnull)locations
{

//    HomeViewController *home = [[HomeViewController alloc] init];


   }





@end
