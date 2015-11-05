//
//  AddTrashareViewController.h
//  Trashare
//
//  Created by Alex Vuijsje on 02-11-15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "HomeViewController.h"

@interface AddTrashareViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) UIImage *picture;

@property(nonatomic, readonly, strong) UINavigationController *navigationController;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)addTrashare:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *addDescription;

//- (IBAction)takePhoto:(UIButton *)sender;



@end
