//
//  WelcomeViewController.h
//  Trashare
//
//  Created by Marina Huber on 11/2/15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "HomeViewController.h"
#import <Parse/Parse.h>


@interface WelcomeViewController : UIViewController

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D userLocation;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;


@end
