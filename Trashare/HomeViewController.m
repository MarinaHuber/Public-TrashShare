//
//  HomeViewController.m
//  Trashare
//
//  Created by Marina Huber on 02-11-15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import "HomeViewController.h"
#import "AddTrashareViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "TrashareCell.h"

@interface HomeViewController () <CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,MKMapViewDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSArray *objectsArray;


@end

@implementation HomeViewController


#pragma mark -viewDidLoad

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TrashareCell" bundle:nil] forCellReuseIdentifier:@"simpleTable"];
    
     PFQuery *query = [PFQuery queryWithClassName:@"TrashareData"];
     self.objectsArray = [query findObjects];

    


}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"TrashareData"];
    self.objectsArray = [query findObjects];
    
    [self.tableView reloadData];
    

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView * _Nonnull)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView * _Nonnull)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    return self.objectsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //forcing xcode to keep pfimageview valid
    [PFImageView class];
    
    
    PFObject *object = self.objectsArray[indexPath.row];
    
    TrashareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"simpleTable" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TrashareCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    // Configure the cell
     PFFile *thumbnail = [object objectForKey:@"imageFile"];
 
    cell.thumbnailImageView.file = thumbnail;
    [cell.thumbnailImageView loadInBackground];
    
    NSString *currentTitle = object[@"titleTrashare"];
    
    cell.descriptionLabel.text = currentTitle;
    
    
    return cell;
}

#pragma mark - UITableVIewDelegate

- (void)tableView:(UITableView * _Nonnull)tableView
didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath {
    //selects the objects we selected touched

    // this is declared as @property in detailviewcontroller and passed on in view did load
    //for string (lable)
    PFObject *object = self.objectsArray[indexPath.row];
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    
    NSString *descriptionString1 = object[@"titleTrashare"];
    
    PFFile *showImage = object[@"imageFile"];
    
    detailVC.file = showImage;
    
    detailVC.descriptionString = descriptionString1;
    
    
   [self.navigationController pushViewController:detailVC animated:YES];
    
    // this is declared as @property in detailviewcontroller and passed on in view did load
    //for image
    
     //detailVC.newImage = images;
}


#pragma mark - ImagePicker

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

- (void)imagePickerController:(UIImagePickerController *)picker
      didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Get picked image from info dictionary
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    AddTrashareViewController *createNew = [[AddTrashareViewController alloc]init];
    
    createNew.picture = image;
    // Put that image onto the screen in our image view
        
    // Dismiss the modal image picker
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    [self presentViewController:createNew animated:YES completion:nil];
    
}
//zoom working
- (void)mapView:(MKMapView *)mapView
didUpdateUserLocation:(MKUserLocation *)userLocation

{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 500, 500);
    [self.mapView setRegion:region animated:YES];
    
}

@end
