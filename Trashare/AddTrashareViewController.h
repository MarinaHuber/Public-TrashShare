//
//  AddTrashareViewController.h
//  Trashare
//
//  Created by Alex Vuijsje on 02-11-15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import <UIKit/UIKit.h>
<<<<<<< HEAD
#import <Parse/Parse.h>
=======
//#import <Parse/Parse.h>
//#import <ParseUI/ParseUI.h>
>>>>>>> 9fb6cda9e1781f1b39549ac53739fffb8134333e
#import "HomeViewController.h"
#import "DetailViewController.h"

@interface AddTrashareViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>
@property (strong, nonatomic) UIImage *picture;
@property(nonatomic, readonly, strong) UINavigationController *navigationController;

//@property (strong, nonatomic) UITextField *textField;

//@property(strong, nonatomic) UIScrollView *scrollView;
//@property(strong, nonatomic) UITextField *textField;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)addTrashare:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *addDescription;

//- (IBAction)takePhoto:(UIButton *)sender;

//@property CGRect frame;

@end
