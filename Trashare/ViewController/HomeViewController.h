//
//  HomeViewController.h
//  Trashare
//
//  Created by Marina Huber on 02-11-15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import "TrashareCell.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
#import "MapAnnotation.h"
#import "HomeViewController.h"
#import "AddTrashareViewController.h"




@interface HomeViewController : UIViewController <UINavigationControllerDelegate>

@property (assign, nonatomic) IBOutlet TrashareCell *trashareCell;
@property (nonatomic) BOOL hasZoomed;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)  NSArray *objectsArray;
@property (nonatomic, strong) NSArray *sortedArray;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) IBOutlet MKMapView *mapView;

@property (nonatomic) PFObject *originalObject;
@property (nonatomic, weak) UIImage *originalImage;
@property (nonatomic) float meters;

@property (nonatomic, strong) NSDate *dateCreated;
@property (nonatomic, strong) NSDate *timeCreated;



@end
