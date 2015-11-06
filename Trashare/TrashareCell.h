//
//  TrashareCell.h
//  Trashare
//
//  Created by Marina Huber on 11/2/15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import <Foundation/Foundation.h>

@interface TrashareCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet PFImageView *thumbnailImageView;
@property (copy, nonatomic) void (^actionBlock)(void);

@end
