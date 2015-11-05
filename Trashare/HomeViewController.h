//
//  HomeViewController.h
//  Trashare
//
//  Created by Alex Vuijsje on 02-11-15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import "TrashareCell.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

// connecting images and parse

@interface HomeViewController : UIViewController <UINavigationControllerDelegate>


@property UIImage *takenPicture;

@property (weak, nonatomic) IBOutlet UITableView *imageCollection;

@end
