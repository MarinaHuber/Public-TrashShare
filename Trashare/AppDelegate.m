//
//  AppDelegate.m
//  Trashare
//
//  Created by Alex Vuijsje on 02-11-15.
//  Copyright © 2015 The App Academy. All rights reserved.
//

#import "AppDelegate.h"
#import "WelcomeViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    
//    // Create location manager object
//    self.locationManager = [[CLLocationManager alloc] init];
//    
//    // There will be a warning from this line of code; ignore it for now
//    [self.locationManager setDelegate:self];
//    
//    // And we want it to be as accurate as possible
//    // regardless of how much time/power it takes
//    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
//    // Tell our manager to start looking for its location immediately
//    //[locationManager startUpdatingLocation];
//    
////    [self.locationManager requestWhenInUseAuthorization];
//    [self.locationManager requestAlwaysAuthorization];
//    
//    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
//    
//    if (authorizationStatus == kCLAuthorizationStatusAuthorized ||
//        authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
//        authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
//        [self.locationManager startUpdatingLocation];
//    }

    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    WelcomeViewController *mvc = [[WelcomeViewController alloc] init];
    self.window.rootViewController = mvc;
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
