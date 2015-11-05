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
@property (strong, nonatomic)  NSArray *objectsArray;
@property (strong, nonatomic) UIImage *thumbnail;



@end

@implementation HomeViewController


#pragma mark -viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.naviagtionItem] create a title
    [self.tableView registerClass:[UITableViewCell class]forCellReuseIdentifier:@"simpleTable"];
//    [self.tableView registerNib:<#(nullable UINib *)#> forCellReuseIdentifier:<#(nonnull NSString *)#>];
     PFQuery *query = [PFQuery queryWithClassName:@"TrashareData"];
     self.objectsArray = [query findObjects];
    
#pragma mark - Navigation

    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.hidesBackButton = YES;
    
    UINavigationItem *trashNavigation = self.navigationItem;
    trashNavigation.title = @"Trashare";}

   //zoom animated

- (void)mapView:(MKMapView *)mapView
 didUpdateUserLocation:(MKUserLocation *)userLocation

{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 500, 500);
    [self.mapView setRegion:region animated:YES];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView * _Nonnull)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView * _Nonnull)tableView
 numberOfRowsInSection:(NSInteger)section{
    
    return self.objectsArray.count;
}

- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView
                  cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath {
    
    PFObject *object = self.objectsArray[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"simpleTable" forIndexPath:indexPath];
  
    if (cell == nil) {
        
    }
   
    
    // Configure the cell
     PFFile *thumbnail = [object objectForKey:@"imageFile"];
     PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:102];
    thumbnailImageView.image = [UIImage imageNamed:@"placeholder.png"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    
    UILabel *titleTrashare = (UILabel*) [cell viewWithTag:100];
    titleTrashare.text = [object objectForKey:@"titleTrashare"];
    
    cell.textLabel.text = [tabeData ];
 //   cell.thumbnailImageView.image = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];


    
    return cell;
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



- (void)imagePickerController:(UIImagePickerController *)picker
      didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Get picked image from info dictionary
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //to add a thumbnail
 //  [self.item setThumbnailFromImage:image];
    
    AddTrashareViewController *createNew = [[AddTrashareViewController alloc]init];
    
    createNew.picture = image;
    // Put that image onto the screen in our image view
    //self.imageView.image = image;
        
    // Dismiss the modal image picker
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    [self.navigationController presentViewController:createNew animated:YES completion:nil];
     
    
}


@end
