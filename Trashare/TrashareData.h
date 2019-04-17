//
//  TrashareData.h
//  Trashare
//
//  Created by Marina Huber on 11/4/15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface TrashareData : PFObject

@property (nonatomic, strong) NSString *titleTrashare; // title
@property (nonatomic, strong) PFFileObject *imageFile; // image
//subclass problem
//@property (nonatomic) CLLocationDistance distance; //calculation from homevc


@end
