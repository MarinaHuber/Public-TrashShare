//
//  AddTrashareViewController.m
//  Trashare
//
//  Created by Alex Vuijsje on 02-11-15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import "AddTrashareViewController.h"
#import "HomeViewController.h"
#import <UIKIT/UIKIT.h>

@interface AddTrashareViewController () <UITextFieldDelegate>

@end

@implementation AddTrashareViewController

- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (IBAction)takePhoto:(UIButton *)sender {
//    
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.delegate = self;
//    picker.allowsEditing = YES;
//    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    
//    [self presentViewController:picker animated:YES completion:NULL];
//    
//}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
   [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.imageView.image = self.picture;
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                        message:@"Device has no camera"
                        delegate:nil
                       cancelButtonTitle:@"OK"
                    otherButtonTitles: nil];
        
       // [myAlertView show];
        
    }
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    textField.delegate = self;
    
    [textField resignFirstResponder];
    return NO;
    
    NSLog(@"%@", textField.text);
    return YES;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    
//    return YES;
//}

@end
