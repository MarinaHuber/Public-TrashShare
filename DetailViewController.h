//
//  DetailViewController.h
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




@interface DetailViewController : UIViewController <UINavigationControllerDelegate, UITableViewDelegate, UIScrollViewDelegate> {
    UIPinchGestureRecognizer *tap;
    BOOL isFullScreen;
    CGRect prevFrame;
}

@property (nonatomic) UIScrollView *myScrollView;
@property (strong, nonatomic) IBOutlet UILabel *dateTrash;

@property (nonatomic, strong) NSString *dateCreated;
@property (nonatomic, strong) NSString *descriptionString;
@property (nonatomic, strong) PFFile *file;

@property (strong, nonatomic) IBOutlet PFImageView *showImage;
@property (strong, nonatomic) IBOutlet UILabel *titleTrash;

- (IBAction)tap:(id)sender;

@end