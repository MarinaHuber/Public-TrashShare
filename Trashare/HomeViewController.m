//
//  HomeViewController.m
//  Trashare
//
//  Created by Alex Vuijsje on 02-11-15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import "HomeViewController.h"
#import "AddTrashareViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface HomeViewController () <CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSMutableArray *namesArray;


@end

@implementation HomeViewController


- (id)init
{
    self = [super init];
    if (self) {
        self.namesArray = @[@"Marina", @"Ikalef", @"Alex", @"Martijn"];
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class]forCellReuseIdentifier:@"simpleTable"];
    
    // Do any additional setup after loading the view from its nib.
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView * _Nonnull)tableView
{
    return 1;
}


- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView
                  cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"simpleTable" forIndexPath:indexPath];
    //    if (cell == nil) {
    //
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"simpleTable"];
    //    }
    cell.textLabel.text = self.namesArray[indexPath.row];
    // the same as- cell.textLabel.text = [self.namesArray objectAtIndex:indexPath.row];
    
    return cell;
}
//data source
- (NSInteger)tableView:(UITableView * _Nonnull)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.namesArray.count;
}


- (IBAction)cameraButton:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    //If the device has a camera, take a picture. Otherwise, just pick from photo library
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    
    //Place image picker on the screen
    [self presentViewController:imagePicker animated:YES completion:NULL];
}

//zoom not working
- (void)mapView:(MKMapView *)mapView
didUpdateUserLocation:(MKUserLocation *)userLocation

{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 500, 500);
    [self.mapView setRegion:region animated:YES];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker
      didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Get picked image from info dictionary
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    AddTrashareViewController *createNew = [[AddTrashareViewController alloc]init];
    
    createNew.picture = image;
    // Put that image onto the screen in our image view
    //self.imageView.image = image;
        
    // Dismiss the modal image picker
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    [self.navigationController presentViewController:createNew animated:YES completion:nil];
     
    
    
}






@end
