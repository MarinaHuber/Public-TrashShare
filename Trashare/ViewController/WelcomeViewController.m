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
@synthesize locationManager = locationManager;

- (void)viewDidLoad {
    [super viewDidLoad];
	self.mapView.showsUserLocation = YES;
	self.mapView.showsBuildings = YES;
	self.navigationController.navigationBarHidden = YES;
}
// shows map location
- (IBAction)authorizationButton:(id)sender {
    
    HomeViewController *map = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:map animated:YES];

	// Create location manager object
	self.mapView.delegate = self;

	// There will be a warning from this line of code; ignore it for now
	[self.locationManager setDelegate:self];

	[self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];


	locationManager = [CLLocationManager new];
	if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
		[locationManager requestWhenInUseAuthorization];
	}
	[locationManager startUpdatingLocation];
//	CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
//
//	if (
//		authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
//		authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
//
//		[self.locationManager startUpdatingLocation];
//
//	}

}

//-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
//	MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:userLocation.coordinate fromEyeCoordinate:CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude) eyeAltitude:1000];
//	[mapView setCamera:camera animated:YES];
//}
////this needed for storing location do get user location from this method instead of MKUserLocation
//- (void)locationManager:(CLLocationManager * _Nonnull)manager
//     didUpdateLocations:(NSArray<CLLocation *> * _Nonnull)locations {
//	[self.locationManager stopUpdatingLocation];
//	CLLocation *currentLocation = [locations firstObject];
//	CGFloat usersLatitude = self.locationManager.location.coordinate.latitude;
//	CGFloat usersLongidute = self.locationManager.location.coordinate.longitude;
//	CLLocationCoordinate2D loc = [currentLocation coordinate];
//	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, usersLatitude, usersLongidute);
//	[self.mapView setRegion:region animated:YES];
//


//    HomeViewController *home = [[HomeViewController alloc] init];
//	home.hasZoomed = NO;
//	CLLocation *currentLocation = [locations firstObject];
//	CLLocationCoordinate2D loc = [currentLocation coordinate];
//	MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 500, 500);
//	[self.mapView setRegion:region animated:YES];
	
//	CLLocation *currentLocation = [locations lastObject];
//	CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
//	[self.locationManager stopUpdatingLocation];
//
//	[geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error){
//		if (placemarks.count > 0){
//			CLPlacemark *placeMark = placemarks[0];
//		   NSLog(@"%@ this is current location???",placeMark.locality);
//		}
//		else if (error == nil&& placemarks.count ==0){
//			NSLog(@"No location and error return");
//		}
//		else if (error){
//			NSLog(@"location error: %@ ",error);
//		}
//	}];


//   }

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
