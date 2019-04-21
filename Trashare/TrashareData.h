//
//  TrashareData.h
//  Trashare
//
//  Created by Marina Huber on 11/4/15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface TrashareData : NSObject

@property (nonatomic, copy) NSString *titleTrashare; // title
@property (nonatomic, strong) PFFileObject *imageFile; // image
@property (nonatomic, strong) PFObject *object; // image

- (id)initWithImage:(PFFileObject *)imageObject title:(NSString *)titleTrash object:(PFObject *)object;


@end
