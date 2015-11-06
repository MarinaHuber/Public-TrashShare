//
//  DEtailViewController.m
//  Trashare
//
//  Created by Marina Huber on 11/6/15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import "DetailViewController.h"
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "HomeViewController.h"
#import "AddTrashareViewController.h"

@interface DetailViewController () <UINavigationControllerDelegate, UITableViewDelegate>


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleTrash.text = self.descriptionString;
   
    //self.showImage.image = self.newImage;


}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
}


@end
