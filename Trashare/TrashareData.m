//
//  TrashareData.m
//  Trashare
//
//  Created by Marina Huber on 11/4/15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import "TrashareData.h"

@implementation TrashareData 

- (id)initWithImage:(PFFileObject *)imageObject title:(NSString *)titleTrash object:(PFObject *)object {
	self = [super init];
	if (self) {
		self.object =  object;
		PFFileObject *objectFile = object[@"imageFile"];
		[self setImageFile: objectFile];

		NSString *title = object[@"titleTrashare"];
		[self setTitleTrashare:title];

	}
	return self;
}

@end
