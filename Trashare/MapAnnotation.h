//
//  MapAnnotation.h
//  Trashare
//
//  Created by Marina Huber on 11/10/15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MKAnnotation.h>
#import "HomeViewController.h"
#import "AddTrashareViewController.h"

<<<<<<< HEAD
@interface MapAnnotation : NSObject <MKAnnotation> 
=======
@interface MapAnnotation : NSObject <MKAnnotation>
>>>>>>> 9fce8ef6facc2d066c653be53ee5f83a700fa8b4

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, strong) PFObject *object;

- (id)initWithCoordinate:(CLLocationCoordinate2D)location title:(NSString *)titleTrash;
- (id)initwithObject:(PFObject *)object;

@end
