//
//  DetailViewController.m
//  Trashare
//
//  Created by Marina Huber on 11/6/15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import "DetailViewController.h"
#import "Trashare-Swift.h"
#import <UIKit/UIKit.h>

@interface DetailViewController () 

@end

@implementation DetailViewController




- (void)viewDidLoad
{
    [super viewDidLoad];

    self.titleTrash.text = self.descriptionString;
   
    self.dateTrash.text = self.dateCreated;

}

- (IBAction)cancelButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
	[self.navigationController setNavigationBarHidden:YES animated:YES];
	self.view.backgroundColor = [UIColor blackColor];
    
}

- (IBAction)tap:(id)sender {
    
        if (!isFullScreen) {
            [UIView animateWithDuration:0.4 delay:0 options:0 animations:^{
                prevFrame = self.showImage.frame;
                [self.showImage setFrame:[[UIScreen mainScreen] bounds]];
            }completion:^(BOOL finished){
                isFullScreen = YES;
            }];
            return;
        }
        else{
            self.titleTrash.alpha = 1.0;
            self.dateTrash.alpha = 1.0;

            [self.navigationController setNavigationBarHidden:NO animated:YES];
            [UIView animateWithDuration:4 delay:0 options:0 animations:^{
                [self.showImage setFrame:prevFrame];
            }completion:^(BOOL finished){
                isFullScreen = NO;
            }];
            return;
        }
    
}

@end
