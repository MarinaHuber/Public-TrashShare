//
//  AddTrashareViewController.m
//  Trashare
//
//  Created by Alex Vuijsje on 02-11-15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import "AddTrashareViewController.h"
#import "HomeViewController.h"
#import <UIKit/UIKit.h>

@interface AddTrashareViewController () <UITextFieldDelegate>

@end

@implementation AddTrashareViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.imageView.image = self.picture;
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertController *alert = [UIAlertController  alertControllerWithTitle: @"Upload Complete" message: @"Successfully saved your Trashare post!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        
        [self presentViewController:alert animated:YES completion:nil];
     
    }
}


- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
   [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

//to make keyboard disapear

- (BOOL)textFieldShouldReturn:(UITextField * _Nonnull)textField
{
    [self.addDescription resignFirstResponder];
    return YES;
}


- (IBAction)addTrashare:(id)sender {
    
    //[self.navigationController pushViewController:map animated:YES];
    
    PFObject *trashare = [PFObject objectWithClassName:@"TrashareData"];
   
    [trashare setObject:self.addDescription.text forKey:@"titleTrashare"];
    
    NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 0.8);
    NSUUID *randomName = [NSUUID UUID];
    PFFile *imageFile = [PFFile fileWithName:randomName.UUIDString data:imageData];
    [trashare setObject:imageFile forKey:@"imageFile"];

    [trashare saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error)
     
        {
            if (!error) {
                // Show success message
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Complete" message:@"Successfully saved your Trashare!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
                // Notify table view to reload the recipes from Parse cloud
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];
                
                // Dismiss the controller
                [self dismissViewControllerAnimated:YES completion:nil];
                
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Failure" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            
            }
        }];
}

@end

       
        
        
        
        
        
            
