//
//  TrashareCell.m
//  Trashare
//
//  Created by Marina Huber on 11/2/15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import "TrashareCell.h"
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

@implementation TrashareCell

+ (NSString *)reuseIdentifier {
	return @"TrashareCell";
}
//what is this?
- (IBAction)showImage:(id)sender
{
    if (self.actionBlock) {
        self.actionBlock();
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
@end
