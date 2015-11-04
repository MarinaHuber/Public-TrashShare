//
//  WelcomeViewController.m
//  Trashare
//
//  Created by Marina Huber on 11/2/15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import "WelcomeViewController.h"
#import "HomeViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface WelcomeViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@end


@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.mapView setShowsUserLocation:YES];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    
}

- (IBAction)authorizationButton:(id)sender {
    
    HomeViewController *map = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:map animated:YES];
    
    // Create location manager object
    self.locationManager = [[CLLocationManager alloc] init];
    
    // There will be a warning from this line of code; ignore it for now
    [self.locationManager setDelegate:self];
    
    // And we want it to be as accurate as possible
    // regardless of how much time/power it takes
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    // Tell our manager to start looking for its location immediately
    //[locationManager startUpdatingLocation];
    
    [self.locationManager requestWhenInUseAuthorization];
    //    [self.locationManager requestAlwaysAuthorization];
   
    
   CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
    
    if (authorizationStatus == kCLAuthorizationStatusAuthorized ||
     authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
      authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
       [self.locationManager startUpdatingLocation];
    
    }
}

//this needed for storing location
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
   
    CLLocation *currentLocations = locations [0];
}
  //zoom not working
- (void)mapView:(MKMapView *)mapView
didUpdateUserLocation:(MKUserLocation *)userLocation

{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    [mapView setRegion:region animated:YES];
    [self.locationManager stopUpdatingLocation];
}





@end
