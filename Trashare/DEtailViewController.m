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

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleTrash.text = self.descriptionString;
   
    self.showImage.file = self.file;

}

- (IBAction)cancelButton:(id)sender {
     HomeViewController *back = [[HomeViewController alloc] init];
    [self presentViewController:back animated:YES completion:nil];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
}


@end
