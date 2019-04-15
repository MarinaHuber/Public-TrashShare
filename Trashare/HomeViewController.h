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
#import <Parse/Parse.h>
#import "MapAnnotation.h"
#import "HomeViewController.h"
#import "AddTrashareViewController.h"




@interface HomeViewController : UIViewController <UINavigationControllerDelegate>

@property (nonatomic) BOOL hasZoomed;


@end
