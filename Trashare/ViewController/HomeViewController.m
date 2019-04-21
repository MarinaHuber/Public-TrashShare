//
//  HomeViewController.m
//  Trashare
//
//  Created by Marina Huber on 02-11-15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import "HomeViewController.h"
#import "AddTrashareViewController.h"
#import "Trashare-Swift.h"
#import "TrashareCell.h"
#import "TrashareData.h"


@interface HomeViewController () <CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,MKMapViewDelegate, UITableViewDelegate, MKAnnotation>
@end

@implementation HomeViewController
@synthesize fileImage = _fileImage;
@synthesize tableView = _tableView;
@synthesize trashareCell = _trashareCell;

#pragma mark -viewDidLoad

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.mapView setDelegate:self];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TrashareCell" bundle:nil] forCellReuseIdentifier:@"TrashareCell"];
	[self reloadParseDataSorted];
	[self loadParseObjectOnMap];
	[UIView animateWithDuration:1.3 delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
		self.activityIndicator.hidden = NO;
		[self.activityIndicator startAnimating];
		self.blurView.alpha = 1;
	} completion:^(BOOL finished) {
		self.activityIndicator.hidden = YES;
		[self.activityIndicator stopAnimating];
		self.blurView.alpha = 0;
	}];
}

- (void)loadParseObjectOnMap {
	NSMutableArray *pointArray = [[NSMutableArray alloc] init];
	 //for every PFObject loop over and find elements in mapObject
	for (PFObject *pfObjectDictionary in self.objectsArray) {
		PFGeoPoint *point = pfObjectDictionary[@"annotationPoint"];
		NSString *title = pfObjectDictionary[@"titleTrashare"];
		CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(point.latitude, point.longitude);

		MapAnnotation *annotation = [[MapAnnotation alloc] initWithCoordinate:coord title:title];
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




- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self.tableView reloadData];
}

- (void)reloadParseDataSorted {
    PFQuery *query = [PFQuery queryWithClassName:@"trashareData"];
    self.objectsArray = [query findObjects];
    
    //sort by date
    NSSortDescriptor *dateDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    NSArray *sortDescriptors = @[dateDescriptor];
    self.sortedArray = [self.objectsArray sortedArrayUsingDescriptors:sortDescriptors];
	[self.tableView reloadData];

    
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView * _Nonnull)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView * _Nonnull)tableView
 numberOfRowsInSection:(NSInteger)section {
    
	return self.objectsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //forcing xcode to keep pfimageview valid??
   [PFFileObject class];


	TrashareCell *cell = (TrashareCell *)[tableView dequeueReusableCellWithIdentifier:[TrashareCell reuseIdentifier]];
	if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"TrashareCell" owner:self options:nil];
		cell = _trashareCell;
		_trashareCell = nil;
	}
	PFObject * trashObject = [self.objectsArray objectAtIndex:indexPath.row];

	[trashObject fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error){
		NSLog(@"retrieved related trash: %@", trashObject);
		cell.descriptionLabel.text = [object objectForKey:@"titleTrashare"];
	}];

     PFFileObject *imageCell = [trashObject objectForKey:@"imageFile"];
	[imageCell getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
		if (!error) {
			UIImage *image = [UIImage imageWithData:imageData];
			cell.thumbnailImageView.image = image;
		}
	}];
	PFObject *distancePFObject = [trashObject objectForKey:@"distance"];
	NSString *i = [NSString stringWithFormat:@"%@", distancePFObject];
	double e = [i doubleValue];
	MKDistanceFormatter *df = [[MKDistanceFormatter alloc]init];
	df.units = 1;
	df.unitStyle = MKDistanceFormatterUnitStyleAbbreviated;

	double c = e * 0.6213;
	NSString *o = [df stringFromDistance: c];
	cell.calculateText.text = o;

//	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//	// set to long number of decimals to accommodate whatever a user might enter
//	[numberFormatter setMaximumFractionDigits:20];
//	[numberFormatter setLocale:[NSLocale currentLocale]];
//	[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
//	NSString *s = [numberFormatter stringFromNumber: [NSNumber numberWithDouble:[i doubleValue]]];
//	cell.calculateText.text = s;

    return cell;
//}  else {
//    alert('please enable location services')
}
//- (double)numberFromString:(NSString *)string {
//	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//	[numberFormatter setLocale:[NSLocale currentLocale]];
//	[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
//	[numberFormatter setMaximumFractionDigits:1];
//	return [numberFormatter stringFromNumber:string];
//}
- (BOOL)isMetric {
	return [[[NSLocale currentLocale] objectForKey:NSLocaleUsesMetricSystem] boolValue];
}

#pragma mark - UITableVIewDelegate

- (void)tableView:(UITableView * _Nonnull)tableView
didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath {
    //selects the objects we selected touched
	[PFFileObject class];
    PFObject *object = self.sortedArray[indexPath.row];
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
	PFFileObject *showImage = object[@"imageFile"];
    
     detailVC.fileImage = showImage;

    NSDate *trashDate = object.createdAt;

    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CET"]];
    [timeFormatter setDateFormat:@"dd-MM-yyyy "];
    NSString *timeCreated = [timeFormatter stringFromDate:trashDate];
    NSString *descriptionString1 = object[@"titleTrashare"];
//    detailVC.titleTrash = descriptionString1;
//    detailVC.dateCreated = [NSString stringWithFormat:@"Added: %@", timeCreated];
    
   // this is declared as @property in detailviewcontroller and passed on in view did load
    
   [self.navigationController pushViewController:detailVC animated:YES];
  
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
      didFinishPickingMediaWithInfo:(NSDictionary *)info {
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


//zoom setUp
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
            
            CLLocation *objectLocation = [[CLLocation alloc] initWithLatitude:point.latitude  longitude:point.longitude];
            
            CLLocationDistance distance = [userLocation.location distanceFromLocation:objectLocation];
            //store for object
            [pfObjectDictionary setObject:@(distance) forKey:@"distance"];
			[self.tableView reloadData];
            
            
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
            //PFFileObject *imageFile = mapAnno.object;
            
//            CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(pin.latitude, pin.longitude);
//            self.coordinate = coord;
            
//            PFFileObject *file = mapAnno.object[@"imageFile"];

//            PFileObject *iconView = [[PFImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
//            iconView.file = file;
//                             [iconView loadInBackground];
//            pinView.leftCalloutAccessoryView = iconView;

        }
        else  {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    return nil;
}



@synthesize coordinate;

@end
