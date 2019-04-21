//
//  TrashareData.m
//  Trashare
//
//  Created by Marina Huber on 11/4/15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import "TrashareData.h"

@implementation TrashareData 

- (id)initWithDistance:(CLLocationDistance)location title:(NSString *)titleTrash {
	self = [super init];
	if (self) {
		self.distance = &(location);
		[self setTitleTrashare:titleTrash];

	}
	return self;
}

- (id)initwithImage:(PFObject *)object{

	if (self) {
		self.object =  object;

	}
	return self;
}

@end
