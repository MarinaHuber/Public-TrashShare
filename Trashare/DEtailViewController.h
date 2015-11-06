//
//  DEtailViewController.h
//  Trashare
//
//  Created by Marina Huber on 11/6/15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import "HomeViewController.h"
#import "AddTrashareViewController.h"




@interface DetailViewController : UIViewController <UINavigationControllerDelegate, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet PFImageView *showImage;
@property (strong, nonatomic) IBOutlet UILabel *titleTrash;

@property (nonatomic, strong) NSString *descriptionString;
@property (nonatomic, strong) PFFile *file;


@end
