//
//  TrashareCell.h
//  Trashare
//
//  Created by Marina Huber on 11/2/15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <Foundation/Foundation.h>


@interface TrashareCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet PFFileObject *thumbnailImageView;
@property (copy, nonatomic) void (^actionBlock)(void);
@property (nonatomic, weak) IBOutlet UILabel *calculateText;

@end
