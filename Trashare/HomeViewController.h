//
//  HomeViewController.h
//  Trashare
//
//  Created by Alex Vuijsje on 02-11-15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import <UIKit/UIKit.h>
// connecting images and parse
@interface HomeViewController : UIViewController <UINavigationControllerDelegate>
{
    NSMutableArray *imagesArray;
}

@property UIImage *takenPicture;

@property (weak, nonatomic) IBOutlet UITableView *imageCollection;

@end
