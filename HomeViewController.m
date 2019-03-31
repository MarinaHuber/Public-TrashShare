//
//  HomeViewController.m
//  Trashare
//
//  Created by Marina Huber on 02-11-15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import "HomeViewController.h"
#import "AddTrashareViewController.h"
#import "TrashareCell.h"
#import "TrashareData.h"

@interface HomeViewController () <CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,MKMapViewDelegate, UITableViewDelegate, MKAnnotation>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)  NSArray *objectsArray;
@property (nonatomic, strong) NSArray *sortedArray;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) IBOutlet MKMapView *mapView;

@property (nonatomic) PFObject *originalObject;
@property (nonatomic) float meters;


@property (nonatomic, strong) NSDate *dateCreated;
@property (nonatomic, strong) NSDate *timeCreated;


@end

@implementation HomeViewController


#pragma mark -viewDidLoad

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.mapView setDelegate:self];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TrashareCell" bundle:nil] forCellReuseIdentifier:@"simpleTable"];
    
    [self reloadParseData];

    
 //for every PFObject loop over and find elements in mapObject
    
    
    NSMutableArray *pointArray = [[NSMutableArray alloc] init];
    
    
    for (PFObject *pfObjectDictionary in self.objectsArray) {
        

        PFGeoPoint *point = pfObjectDictionary[@"annotationPoint"];
        NSString *title = pfObjectDictionary[@"titleTrashare"];
        
            CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(point.latitude, point.longitude);

            //this creates corresponding map object
            MapAnnotation *annotation = [[MapAnnotation alloc] initWithCoordinate:coord title:title];
//
//            
            [pointArray addObject:annotation];

        PFGeoPoint *pin = pfObjectDictionary[@"annotationPoint"];

        if (pin) {
  
            //this creates corresponding map object
            MapAnnotation *annotation = [[MapAnnotation alloc] initwithObject: pfObjectDictionary];
            
            
            [pointArray addObject:annotation];
            
        }
       

        
        [self.mapView addAnnotations:pointArray];
        
    }
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    //why is this twice?
    [self reloadParseData];
    
    [self.tableView reloadData];
   //[self.mapViewWillStartLoadingMap:mapView didUpdateUserLocation:userLocation]

    
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
    cell.calculateText.text = [NSString stringWithFormat:@"%@", [object objectForKey:@"distance1"]];
  
   
    

    
    return cell;
//}  else {
//    alert('please enable location services')
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
    
    
    PFFile *showImage = object[@"imageFile"];
    
    detailVC.file = showImage;
   
    
    NSDate *trashDate = object.createdAt;

    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CET"]];
    [timeFormatter setDateFormat:@"HH:mm"];
    NSString *timeCreated = [timeFormatter stringFromDate:trashDate];
    
    detailVC.descriptionString = descriptionString1;
    detailVC.dateCreated = [NSString stringWithFormat:@"Added: %@", timeCreated];
    
   // this is declared as @property in detailviewcontroller and passed on in view did load
    
   [self.navigationController pushViewController:detailVC animated:YES];
  
}

//this method doesnt show
- (NSString *)dateOnlyForTest:(NSDate *)trashDate {

    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CET"]];
    [dateFormatter setDateFormat:@"dd-MM-yyyy "];
    NSString *dateCreated = [dateFormatter stringFromDate:trashDate];
    
    return dateCreated;

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
didUpdateUserLocation:(MKUserLocation *)userLocation {

    if (self.hasZoomed == NO) {
        
        CLLocationCoordinate2D loc = [userLocation coordinate];
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 500, 500);
        [self.mapView setRegion:region animated:YES];
        
        self.hasZoomed = YES;
    }
    
    for (PFObject *pfObjectDictionary in self.objectsArray) {
        
        
        PFGeoPoint *point = pfObjectDictionary[@"annotationPoint"];
        
        
        if (point) {
            
            
            
            //creating currentLocation and other location for calculate distance
            
            CLLocation *objectLoc = [[CLLocation alloc] initWithLatitude:point.latitude  longitude:point.longitude];
            
            CLLocationDistance distance = [userLocation.location distanceFromLocation:objectLoc];
            //store for object
            [pfObjectDictionary setObject:@(distance) forKey:@"distance1"];
            
            
        }
    }
    
}







- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id <MKAnnotation>)annotation
{
    MapAnnotation *mapAnno = (MapAnnotation *)annotation;
    
    // If the annotation is the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MapAnnotation class]])
    {
        // Try to dequeue an existing pin view first.

        MKPinAnnotationView *pinView = (MKPinAnnotationView*)[mapView
   dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];

        
        
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:@"CustomPinAnnotationView"];
        
            pinView.pinTintColor = UIColor.greenColor;
            pinView.animatesDrop = YES;
            pinView.canShowCallout = YES;
            pinView.image = [UIImage imageNamed:@"my.png"];
            
            // If appropriate, customize the callout by adding accessory views (code not shown).
            
            // Add an image to the left callout.
            //PFFile *imageFile = mapAnno.object;
            
//            CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(pin.latitude, pin.longitude);
//            self.coordinate = coord;
            
            PFFile *file = mapAnno.object[@"imageFile"];
            
            PFImageView *iconView = [[PFImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
            iconView.file = file;
                             [iconView loadInBackground];
            pinView.leftCalloutAccessoryView = iconView;
            
        }
        else  {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    return nil;
}



@end
