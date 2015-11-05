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
        
        UIAlertController *alert = [UIAlertController  alertControllerWithTitle: @"Upload Complete" message: @"Successfully saved your #Lekker post!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
        
       // [myAlertView show];
        
    }
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    textField.delegate = self;
    
    [textField resignFirstResponder];
    return NO;

    return YES;
}



- (IBAction)addTrashare:(id)sender {
    
    PFObject *trashare = [PFObject objectWithClassName:@"TrashareData"];
    //   NSLog(@"%@", self.addDescription.text);
    
    
    [trashare setObject:self.addDescription.text forKey:@"titleTrashare"];
    
    NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 0.8);
    NSUUID *randomName = [NSUUID UUID];
    PFFile *imageFile = [PFFile fileWithName:randomName.UUIDString data:imageData];
    [trashare setObject:imageFile forKey:@"imageFile"];

    [trashare saveInBackground];

}
@end
