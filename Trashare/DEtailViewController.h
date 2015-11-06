//
//  DEtailViewController.h
//  Trashare
//
//  Created by Marina Huber on 11/6/15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface DetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *showImage;
@property (strong, nonatomic) IBOutlet UILabel *titleTrash;

@property (nonatomic, strong) NSString *descriptionString;
//@property (nonatomic, strong) UIImage *newImage;


@end
