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
    self.navigationController.navigationBarHidden = YES;
	self.mapView.delegate = self;

//
//	CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
//
//	if (
//		authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
//		authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
//
//		[self.locationManager startUpdatingLocation];
//
//	}

	if ([ CLLocationManager locationServicesEnabled]) { // Determine if the location service is turned on
		self .locationManager = [[ CLLocationManager alloc] init]; //Initialize the locator
		[ self .locationManager startUpdatingLocation]; // start locator
	}
	if ([ CLLocationManager locationServicesEnabled]){
		self .locationManager = [[ CLLocationManager alloc] init]; //Initialize the locator
		self .locationManager.delegate = self ; //Set the proxy
		self .locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers; //Set the precision
		self .locationManager.distanceFilter = kCLDistanceFilterNone ; //indicates that the location information is updated
		[ self .locationManager requestWhenInUseAuthorization]; //Use the requestWhenInUseAuthorization method
		[ self .locationManager startUpdatingLocation]; //Start locator
	}
    
}
// shows map location
- (IBAction)authorizationButton:(id)sender {
    
    HomeViewController *map = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:map animated:YES];
}

////this needed for storing location do get user location from this method instead of MKUserLocation
- (void)locationManager:(CLLocationManager * _Nonnull)manager
     didUpdateLocations:(NSArray<CLLocation *> * _Nonnull)locations {

//    HomeViewController *home = [[HomeViewController alloc] init];
	[self.locationManager stopUpdatingLocation];
	CLLocation *currentLocation = [locations lastObject];
	CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
	[self.locationManager stopUpdatingLocation];

	[geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error){
		if (placemarks.count > 0){
			CLPlacemark *placeMark = placemarks[0];
		   NSLog(@"%@ this is current location???",placeMark.locality);
		}
		else if (error == nil&& placemarks.count ==0){
			NSLog(@"No location and error return");
		}
		else if (error){
			NSLog(@"location error: %@ ",error);
		}
	}];


   }

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	[self showLocationAlert];
}

-(void)showLocationAlert {
	UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"允许\"定位\"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction * ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		//打开定位设置
		NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
		[[UIApplication sharedApplication] openURL:settingsURL];
	}];
	UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

	}];
	[alertVC addAction:cancel];
	[alertVC addAction:ok];
	[self presentViewController:alertVC animated:YES completion:nil];
}





@end
