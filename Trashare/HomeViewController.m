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

@interface HomeViewController () <CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,MKMapViewDelegate, UITableViewDelegate, MKAnnotation>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSArray *objectsArray;
@property (strong, nonatomic) NSArray *sortedArray;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic) CLLocationCoordinate2D userLocation;
@property (nonatomic) PFObject *originalObject;



@end

@implementation HomeViewController


#pragma mark -viewDidLoad

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TrashareCell" bundle:nil] forCellReuseIdentifier:@"simpleTable"];
    
    [self reloadParseData];
    
 //for every PFObject loop over and find elements in mapObject
    
    NSMutableArray *pinArray = [[NSMutableArray alloc] init];
    
    
    for (PFObject *pfObjectDictionary in self.objectsArray) {
        
        
        PFGeoPoint *pin = pfObjectDictionary[@"annotationPoint"];
        
        // pin.latitude
        // pin.longitude
        if (pin) {
            
            //   NSLog(@"%@", pin);
            
            CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(pin.latitude, pin.longitude);
            
            // pin.center.latitude =
            //this creates corresponding map object
            MapAnnotation *annotation = [[MapAnnotation alloc] initWithCoordinate:coord title:@"titleTrashare"];
            
          
            [pinArray addObject:annotation];
            
        }
        
        [self.mapView addAnnotations:pinArray];
        
    }

    }


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    [self reloadParseData];
    
    [self.tableView reloadData];
    
}

- (void)reloadParseData
{
    PFQuery *query = [PFQuery queryWithClassName:@"TrashareData"];
    self.objectsArray = [query findObjects];
    
    //sort by date
    NSSortDescriptor *ageDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    NSArray *sortDescriptors = @[ageDescriptor];
    self.sortedArray = [self.objectsArray sortedArrayUsingDescriptors:sortDescriptors];
    
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView * _Nonnull)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView * _Nonnull)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    return self.sortedArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //forcing xcode to keep pfimageview valid
    [PFImageView class];
    
    PFObject *object = self.sortedArray[indexPath.row];
    
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
    PFObject *object = self.sortedArray[indexPath.row];
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    
    NSString *descriptionString1 = object[@"titleTrashare"];
    
   // NSDate *trashDate = object[@"createdAt"];
    
    PFFile *showImage = object[@"imageFile"];
    
    detailVC.file = showImage;
    
 //   detailVC.dateCreated = trashDate;
    
    detailVC.descriptionString = descriptionString1;
    
    
   [self.navigationController pushViewController:detailVC animated:YES];
    
    // this is declared as @property in detailviewcontroller and passed on in view did load
  
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
        
    // Dismiss the modal image picker, there are few ways to do it (push/pop, present/dismiss)
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    [self presentViewController:createNew animated:YES completion:nil];
    
}
#pragma mark - Annoting Maps

//zoom working

- (void)mapView:(MKMapView *)mapView
didUpdateUserLocation:(MKUserLocation *)userLocation

{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 500, 500);
    [self.mapView setRegion:region animated:YES];
    
 }


- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If the annotation is the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MapAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        MKPinAnnotationView*    pinView = (MKPinAnnotationView*)[mapView
                                                                 dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:@"CustomPinAnnotationView"];
        
            pinView.pinTintColor = UIColor.redColor;
            pinView.animatesDrop = YES;
            pinView.canShowCallout = YES;
            
            // If appropriate, customize the callout by adding accessory views (code not shown).
        }
        else
            pinView.annotation = annotation;
        
        return pinView;
    }
    
    return nil;
}


//example



@end
