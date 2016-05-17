//
//  ViewController.h
//  IndoorMappingiOS
//
//  Created by Alotaibi, Waleed N on 11/6/15.
//  Copyright © 2015 Alotaibi, Waleed N. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;
@import CoreLocation;
#import "Building.h"

#import <KontaktSDK/KontaktSDK.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, KTKBeaconManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *indoorMap;

@property (weak, nonatomic) IBOutlet UILabel *currentLocationField;

@property (weak, nonatomic) IBOutlet UILabel *currentLocationFieldBeacon;

// CoreLocation properties
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (nonatomic, strong) Building *building;

// Detail item to be used to configure the map with the floorplan
@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UITextField *roomNumberToSearch;

@property KTKBeaconManager *beaconManager;

@property KTKBeaconRegion *region;

@property CLBeacon *nearestBeacon;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (weak, nonatomic) IBOutlet UILabel *floorNumLabel;

@property NSMutableArray *list;

-(NSMutableArray *)currentLocationPoint:(NSArray <CLBeacon *>*)beacons;

@property NSArray *relevantsBeacons;

- (void)beaconManager:(KTKBeaconManager*)manager didRangeBeacons:(NSArray <CLBeacon *>*)beacons inRegion:(__kindof KTKBeaconRegion*)region;

@end
