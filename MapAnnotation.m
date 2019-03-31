//
//  MapAnnotation.m
//  Trashare
//
//  Created by Marina Huber on 11/10/15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import "MapAnnotation.h"


@implementation MapAnnotation


- (id)initWithCoordinate:(CLLocationCoordinate2D)location title:(NSString *)titleTrash {
    self = [super init];
    if (self) {
        self.coordinate = location;
        [self setTitle: titleTrash];
        
    }
    return self;
}

- (id)initwithObject:(PFObject *)object{
 
    if (self) {
        self.object =  object;
    PFGeoPoint *pin = object[@"annotationPoint"];
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(pin.latitude, pin.longitude);
        self.coordinate = coord;
        
        NSString *title = object[@"titleTrashare"];
        [self setTitle: title];
    }
    return self;
}
@end

