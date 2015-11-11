//
//  DetailViewController.m
//  Trashare
//
//  Created by Marina Huber on 11/6/15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import "DetailViewController.h"
#import <UIKit/UIKit.h>

@interface DetailViewController () 

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.titleTrash.text = self.descriptionString;
   
  //  self.dateTrash.text = self.dateCreated;
    
    self.showImage.file = self.file;
    
    

}

- (IBAction)cancelButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}


@end
