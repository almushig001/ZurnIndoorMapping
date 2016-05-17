//
//  ViewController.m
//  IndoorMappingiOS
//
//  Created by Alotaibi, Waleed N on 11/6/15.
//  Copyright © 2015 Alotaibi, Waleed N. All rights reserved2.
//

#import "ViewController.h"
#import "MapOverlay.h"
#import "MapOverlayView.h"
#import "FloorPlanPDF.h"
#include <math.h>

//coordinates for room 322: 42.127207, -80.087615

@interface ViewController ()

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mySegmentedControl;
@end

@implementation ViewController


- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.building = [[Building alloc] initWithName:[self.detailItem description]];
        self.building.floorNum = @"First";
//        self.building.buildingName = [self.detailItem description];
        [self setRegion];
        [self addOverlay];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCoreLocation];
    [self startBeacon];
    [self configureView];
    [self readPDF];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)refreshRegion:(id)sender {
    
    self.mySegmentedControl.selectedSegmentIndex = 0;
    [self removeAllOverlays];
    [self viewDidLoad];
}

- (void)initCoreLocation
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager  requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation* currentLocation;
    currentLocation = [locations lastObject];
    // here we get the current location
    
}

- (void)setRegion
{
//    CLLocationCoordinate2D coord;
    
    NSArray *objectsPlist = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"GUBuildingsList" ofType:@"plist"]];
    
    int item = (int)[objectsPlist indexOfObject:self.building.buildingName];

    switch (item) {
  case 0:
    {
    //42.126920, -80.087162
//    coord = CLLocationCoordinate2DMake(42.126920,-80.087162);
    }
    break;
    }
    
    CLLocationDistance distanceinMeters = 90;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.building.centerCoord, distanceinMeters , distanceinMeters);
    [self.indoorMap setRegion:region];

}

- (void)addOverlay {
    
    
    MapOverlay *overlay = [[MapOverlay alloc] initWithBuilding:self.building];
    
    [self.indoorMap addOverlay:overlay];
}
- (void)removeAllOverlays {

[self.indoorMap removeOverlays:self.indoorMap.overlays];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    
    MapOverlayView *overlayView = [[MapOverlayView alloc] initWithOverlay:overlay withBuilding:self.building];
    
    return overlayView;
    
}

- (void)readPDF
{
    FloorPlanPDF *newFloorMapReader = [FloorPlanPDF alloc];
    [newFloorMapReader initPDFwithFloorNum:3];
}

- (void)showRoom:(CLLocationCoordinate2D *)coordinate room: (NSString*)roomNum
{
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(*coordinate, 90, 90);
//    [self.indoorMap setRegion:[self.indoorMap regionThatFits:region] animated:YES];
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = *(coordinate);
    point.title = roomNum;
    
    [self.indoorMap addAnnotation:point];

}

-(IBAction)searchRoom:(id)sender{
    CLLocationCoordinate2D coordinate;
    
    if([self.roomNumberToSearch.text isEqual:@"322"]){
        //display the coordinate point for this room
        coordinate = CLLocationCoordinate2DMake(42.127207, -80.087615);
        [self showRoom:&coordinate room:self.roomNumberToSearch.text];
    }
    else if([self.roomNumberToSearch.text isEqual:@"354"]){
        //these coordinates are actually for 353 but don't align with current image
        coordinate = CLLocationCoordinate2DMake(42.126525, -80.087146);
        [self showRoom:&coordinate room:self.roomNumberToSearch.text];
    }
    
    else if([self.roomNumberToSearch.text isEqual:@"11"]){
        //these coordinates are actually for 353 but don't align with current image
        coordinate = CLLocationCoordinate2DMake(42.127171,-80.087129);
        [self showRoom:&coordinate room:self.roomNumberToSearch.text];
    }
    
    else if([self.roomNumberToSearch.text isEqual:@"12"]){
        //these coordinates are actually for 353 but don't align with current image
        coordinate = CLLocationCoordinate2DMake(42.127246,-80.087347);
        [self showRoom:&coordinate room:self.roomNumberToSearch.text];
    }
    
    else if([self.roomNumberToSearch.text isEqual:@"13"]){
        //these coordinates are actually for 353 but don't align with current image
        coordinate = CLLocationCoordinate2DMake(42.126642,-80.086915);
        [self showRoom:&coordinate room:self.roomNumberToSearch.text];
    }
    [self.view endEditing:YES];
}

- (void)updateView
{
    [self setRegion];
    [self addOverlay];
}


- (IBAction)mySegmentedControlAction:(id)sender {
    
    switch (self.mySegmentedControl.selectedSegmentIndex) {
        case 0:
            self.building.floorNum = [self.mySegmentedControl titleForSegmentAtIndex:self.mySegmentedControl.selectedSegmentIndex];
            
            break;
        case 1:
            self.building.floorNum = [self.mySegmentedControl titleForSegmentAtIndex:self.mySegmentedControl.selectedSegmentIndex];
            break;
        case 2:
            self.building.floorNum = [self.mySegmentedControl titleForSegmentAtIndex:self.mySegmentedControl.selectedSegmentIndex];
            break;
        case 3:
            self.building.floorNum = [self.mySegmentedControl titleForSegmentAtIndex:self.mySegmentedControl.selectedSegmentIndex];
            break;
    }
    
    [self removeAllOverlays];
    [self updateView];
}

// beacons methods

-(void)startBeacon

{

    [self initBeaconMang];
    [self BeaconRegion];

}

-(void)initBeaconMang
{
    self.beaconManager = [[KTKBeaconManager alloc] initWithDelegate:self];
    // Request Location Authorization
    [self.beaconManager requestLocationAlwaysAuthorization];
}

-(void)BeaconRegion
{

    // Kontakt.io proximity UUID
    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:@"f7826da6-4fa2-4e98-8024-bc5b71e0893e"];
    
    // Create region instance
    
    self.region = [[KTKBeaconRegion alloc] initWithProximityUUID: proximityUUID major:1 identifier:@"identifier"];
    
    self.region.notifyOnEntry=YES;
    self.region.notifyOnExit=YES;
    self.region.notifyEntryStateOnDisplay=YES;
    
    // Start ranging
    [self.beaconManager startRangingBeaconsInRegion: self.region];
    
    // Start Monitoring
    [self.beaconManager startMonitoringForRegion: self.region];
    

}

- (void)beaconManager:(KTKBeaconManager*)manager didStartMonitoringForRegion:(__kindof KTKBeaconRegion*)region
{
    [self.beaconManager requestStateForRegion:self.region];
    
}

- (void)beaconManager:(KTKBeaconManager*)manager didDetermineState:(CLRegionState)state forRegion:(__kindof KTKBeaconRegion*)region
{
    if (state == CLRegionStateInside)
    {
    // Start ranging ...
//    [manager startRangingBeaconsInRegion:self.region];
    
    }
    
    else
    {
        NSLog(@"Failed");
    }
    
    

}

- (void)beaconManager:(KTKBeaconManager*)manager didChangeLocationAuthorizationStatus:(CLAuthorizationStatus)status;
{
    // ...
}

- (void)beaconManager:(KTKBeaconManager*)manager didEnterRegion:(__kindof KTKBeaconRegion*)region
{
    NSLog(@"Enter region %@", region);
}

- (void)beaconManager:(KTKBeaconManager*)manager didExitRegion:(__kindof KTKBeaconRegion*)region
{
    NSLog(@"Exit region %@", region);
}

- (void)beaconManager:(KTKBeaconManager*)manager didRangeBeacons:(NSArray <CLBeacon *>*)beacons inRegion:(__kindof KTKBeaconRegion*)region
{
//    NSLog(@"Ranged beacons count: %lu", [beacons count]);
    //NSLog(@"Ranged beacons count: %lu", [beacons objectAtIndex:1].rssi);
//    
//    CLBeacon *first =[beacons firstObject];
//    
//    
////    NSLog(@"rssi:%f", first.accuracy);
//    
//    
//    // Source code from http://stackoverflow.com/questions/23290544/how-to-know-the-closest-ibeacon
    
    NSPredicate *predicateIrrelevantBeacons = [NSPredicate predicateWithFormat:@"(self.accuracy != -1) AND ((self.proximity != %d) OR (self.proximity != %d))", CLProximityFar,CLProximityUnknown];
    self.relevantsBeacons = [beacons filteredArrayUsingPredicate: predicateIrrelevantBeacons];
//    NSPredicate *predicateMin = [NSPredicate predicateWithFormat:@"self.accuracy == %@.@min.accuracy",
    
    NSMutableArray *points = [self currentLocationPoint:[self.relevantsBeacons mutableCopy]];
    
    if (points.count > 0) {
        
    
    MKMapPoint currentLocationPoint;
    
    currentLocationPoint.x = [[points objectAtIndex:0] doubleValue];
    currentLocationPoint.y = [[points objectAtIndex:1] doubleValue];
    
        
        
    [self findMinDistince:currentLocationPoint];
    
    }
    
    else
    {
    
        self.currentLocationField.text = @"You are not near any Beacons";
    }
    

}

-(void)configureKIbeacon

{
    [self getBeaconProximity:self.nearestBeacon];
    self.building.floorNum = [[self getFloorNumb:self.nearestBeacon] stringValue];
    [self calculateDistance:self.nearestBeacon];
    self.floorNumLabel.text = [@"Floor: " stringByAppendingString:[[self getFloorNumb:self.nearestBeacon] stringValue]];
}

-(CLLocationAccuracy)calculateDistance:(CLBeacon*)beacon

{
//    NSLog(@"distance is: %f",beacon.accuracy);
    return beacon.accuracy;
}

-(NSNumber*)getFloorNumb:(CLBeacon*)beacon

{
//    NSLog(@"FloorNumber is: %@",beacon.major);
    
    return beacon.minor;
}

-(NSString*)getBeaconProximity:(CLBeacon*)beacon

{
    NSString *proximity;
    switch (beacon.proximity) {
        case CLProximityNear:
            proximity = @"Near";
            break;
        case CLProximityImmediate:
            proximity = @"Immediate";
            break;
        case CLProximityFar:
            proximity = @"Far";
            break;
        case CLProximityUnknown:
        default:
            proximity = @"Unknown";
            break;
    }
    
//    NSLog(@"the proximity %@", proximity);
    return proximity;
    
    
}

//-(NSMutableArray *)currentLocationPoint:(NSArray <CLBeacon *>*)beacons
//{
//
//    NSMutableArray *triPt;
//    NSString *error = @"";
//    
//    if ([KTKBeaconManager isMonitoringAvailable]) {
//        
//        if (beacons.count > 3)
//        {
//            double DistA, DistB, DistC;
//            MKMapPoint b1, b2 , b3;
//            for (NSUInteger i = 0; i < beacons.count; i++)
//            {
//                NSString *filePath = [[NSBundle mainBundle] pathForResource:@"TheBeacons" ofType:@"plist"];
//                
//                NSDictionary *properties = [NSDictionary dictionaryWithContentsOfFile:filePath];
//                
//                CLBeacon *abeacon = [beacons objectAtIndex:i];
//                NSString *key = [NSString stringWithFormat:@"%@", abeacon.minor];
//                CGPoint tempPoint = CGPointFromString(properties[key]);
//                CLLocationCoordinate2D tempCoordinate = CLLocationCoordinate2DMake(tempPoint.x, tempPoint.y);
//                if (i == 0) {
//                    b1 = MKMapPointForCoordinate(tempCoordinate);
//                    DistA = [self calculateAccuracyWithRssi:abeacon.rssi forMinor:abeacon.minor];
//                    
//                }
//                
//                if (i == 1) {
//                    b2 = MKMapPointForCoordinate(tempCoordinate);
//                    DistB = [self calculateAccuracyWithRssi:abeacon.rssi forMinor:abeacon.minor];
//                    
//                }
//                
//                if (i == 2) {
//                    b3 = MKMapPointForCoordinate(tempCoordinate);
//                    DistC = [self calculateAccuracyWithRssi:abeacon.rssi forMinor:abeacon.minor];
//                    
//                }
//                
//            }
//                    NSLog(@"distA:@%f",DistA);
//                    NSLog(@"distB:@%f",DistB);
//                    NSLog(@"distC:@%f",DistC);
//            
//                NSMutableArray *P1,*P2,*P3;
//            
//                //P1,P2,P3 is the point and 2-dimension vector
//                P1 = [[NSMutableArray alloc] initWithCapacity:0];
//                [P1 addObject:[NSNumber numberWithDouble:b1.x]];
//                [P1 addObject:[NSNumber numberWithDouble:b1.y]];
//            [P1 addObject:[NSNumber numberWithDouble:0.0]];
//            
//                P2 = [[NSMutableArray alloc] initWithCapacity:0];
//                [P2 addObject:[NSNumber numberWithDouble:b2.x]];
//                [P2 addObject:[NSNumber numberWithDouble:b2.y]];
//            [P2 addObject:[NSNumber numberWithDouble:0.0]];
//            
//                P3 = [[NSMutableArray alloc] initWithCapacity:0];
//                [P3 addObject:[NSNumber numberWithDouble:b3.x]];
//                [P3 addObject:[NSNumber numberWithDouble:b3.y]];
//            [P3 addObject:[NSNumber numberWithDouble:0.0]];
//            
//            
//            // ex = (P2 - P1)/(numpy.linalg.norm(P2 - P1))
//            double ex[] = { 0, 0, 0 };
//            double P2P1 = 0;
//            
//            for (NSUInteger i = 0; i < 3; i++) {
//                P2P1 += pow([[P2 objectAtIndex:i] doubleValue] - [[P1 objectAtIndex:i] doubleValue], 2);
//            }
//            
//            for (NSUInteger i = 0; i < 3; i++) {
//                ex[i] = ([[P2 objectAtIndex:i] doubleValue] - [[P1 objectAtIndex:i] doubleValue]) / sqrt(P2P1);
//            }
//            
//            // i = dot(ex, P3 - P1)
//            double p3p1[] = { 0, 0, 0 };
//            
//            for (NSUInteger i = 0; i < 3; i++) {
//                p3p1[i] = [[P3 objectAtIndex:i] doubleValue] - [[P1 objectAtIndex:i] doubleValue];
//            }
//            
//            double ivar = 0;
//            
//            for (NSUInteger i = 0; i < 3; i++) {
//                ivar += (ex[i] * p3p1[i]);
//            }
//            
//            // ey = (P3 - P1 - i*ex)/(numpy.linalg.norm(P3 - P1 - i*ex))
//            double p3p1i = 0;
//            
//            for (NSUInteger  i = 0; i < 3; i++) {
//                p3p1i += pow([[P3 objectAtIndex:i] doubleValue] - [[P1 objectAtIndex:i] doubleValue] - ex[i] * ivar, 2);
//            }
//            
//            double ey[] = { 0, 0, 0};
//            
//            for (NSUInteger i = 0; i < 3; i++) {
//                ey[i] = ([[P3 objectAtIndex:i] doubleValue] - [[P1 objectAtIndex:i] doubleValue] - ex[i] * ivar) / sqrt(p3p1i);
//            }
//            
//            // ez = numpy.cross(ex,ey)
//            // if 2-dimensional vector then ez = 0
//            double ez[] = { 0, 0, 0 };
//            
//            // d = numpy.linalg.norm(P2 - P1)
//            double d = sqrt(P2P1);
//            
//            // j = dot(ey, P3 - P1)
//            double jvar = 0;
//            
//            for (NSUInteger i = 0; i < 3; i++) {
//                jvar += (ey[i] * p3p1[i]);
//            }
//            
//            // from wikipedia
//            // plug and chug using above values
//            double x = (pow(DistA, 2) - pow(DistB, 2) + pow(d, 2)) / (2 * d);
//            double y = ((pow(DistC, 2) - pow(DistC, 2) + pow(ivar, 2)
//                          + pow(jvar, 2)) / (2 * jvar)) - ((ivar / jvar) * x);
//            
//            // only one case shown here
//            double z = sqrt(pow(DistA, 2) - pow(x, 2) - pow(y, 2));
//            
//            if (isnan(z)) z = 0;
//            
//            // triPt is an array with ECEF x,y,z of trilateration point
//            // triPt = P1 + x*ex + y*ey + z*ez
//            double triPtTemp[] = { 0, 0, 0 };
//            
//            for (NSUInteger i = 0; i < 3; i++) {
//                triPtTemp[i] =  [[P1 objectAtIndex:i] doubleValue] + ex[i] * x + ey[i] * y + ez[i] * z;
//            }
//            
//            // convert back to lat/long from ECEF
//            // convert to degrees
//            double lon = triPtTemp[0];
//            double lat = triPtTemp[1];
//            triPt = [[NSMutableArray alloc] initWithCapacity:0];
//            [triPt addObject:[NSNumber numberWithDouble:lon]];
//            [triPt addObject:[NSNumber numberWithDouble:lat]];
//            
//        return triPt;
//            
//        }
//        
//    }
//return triPt;
//}

-(NSMutableArray *)currentLocationPoint:(NSArray <CLBeacon *>*)beacons
{
    // 2-d trit
    // dist im miles : ([self calculateAccuracyWithRssi:abeacon.rssi forMinor:abeacon.minor]/1000) * 1.609344;
    // mi = m * 0.00062137
    
    
    
    NSMutableArray *triPt;
    NSString *error = @"";
    
//    if ([KTKBeaconManager isMonitoringAvailable]) {
    
        if (beacons.count > 3)
        {
            double DistA, DistB, DistC;
            double xA, yA, zA , xB, yB, zB , xC, yC, zC;
            double R = 6372.8;
            for (NSUInteger i = 0; i < beacons.count; i++)
            {
                NSString *filePath = [[NSBundle mainBundle] pathForResource:@"TheBeacons" ofType:@"plist"];
                
                NSDictionary *properties = [NSDictionary dictionaryWithContentsOfFile:filePath];
                
                CLBeacon *abeacon = [beacons objectAtIndex:i];
                NSString *key = [NSString stringWithFormat:@"%@", abeacon.minor];
                CGPoint tempPoint = CGPointFromString(properties[key]);
                CLLocationCoordinate2D tempCoordinate = CLLocationCoordinate2DMake(tempPoint.x, tempPoint.y);
                if (i == 0) {
                    double pointPerMeter = MKMapPointsPerMeterAtLatitude(tempCoordinate.latitude);
                    DistA =  pointPerMeter * [self calculateAccuracyWithRssi:abeacon.rssi forMinor:abeacon.minor];
                    
                    double metersPrPoi = MKMetersPerMapPointAtLatitude(tempCoordinate.latitude);
                    //0.110478
                    double pontPrMeter = MKMapPointsPerMeterAtLatitude(tempCoordinate.latitude);
                    //9.051672
                    NSLog(@"distA:@%f",DistA);
                    MKMapPoint b1 = MKMapPointForCoordinate(tempCoordinate);
                    xA = b1.x;
                    
                    yA = b1.y;
                    
                    zA = 0;
                    
                }
                
                if (i == 1) {
                    double pointPerMeter = MKMapPointsPerMeterAtLatitude(tempCoordinate.latitude);
                    DistB = pointPerMeter * [self calculateAccuracyWithRssi:abeacon.rssi forMinor:abeacon.minor];
                    NSLog(@"distB:@%f",DistB);
                    MKMapPoint b1 = MKMapPointForCoordinate(tempCoordinate);
                    xB = b1.x;
                    
                    yB = b1.y;
                    zB = 0;
                    
                }
                
                if (i == 2) {
                    double pointPerMeter = MKMapPointsPerMeterAtLatitude(tempCoordinate.latitude);
                    DistC = pointPerMeter * [self calculateAccuracyWithRssi:abeacon.rssi forMinor:abeacon.minor];
                    NSLog(@"distC:@%f",DistC);
                    
                    MKMapPoint b1 = MKMapPointForCoordinate(tempCoordinate);
                    xC = b1.x;
                    
                    yC = b1.y;
                    
                    zC = 0;
                    
                }
                
            }
            NSLog(@"distA:@%f",DistA);
            NSLog(@"distB:@%f",DistB);
            NSLog(@"distC:@%f",DistC);
            
            
            
            double P1[] = {xA, yA, zA};
            double P2[] = {xB, yB, zB};
            double P3[] = {xC, yC, zC};
            
            // transform to get circle 1 at origin
            // transform to get circle 2 on x axis
            
            // ex = (P2 - P1)/(numpy.linalg.norm(P2 - P1))
            
            double ex[] = {0, 0,0};
            double P2P1 = 0;
            
            for (NSUInteger i = 0; i < 3; i++) {
                P2P1 += pow(P2[i]- P1[i], 2);
            }
            
            double dis1 = sqrt(P2P1);
            
            NSLog(@"ds11: %f",dis1);
            
//            MKMapPoint b3,b2;
//            b3.x = P1[0];
//            b3.y = P1[1];
//            
//            b2.x = P2[0];
//            b2.y = P2[1];
            
            
            
//            double dis = MKMetersBetweenMapPoints(b3, b2);
            
//            NSLog(@"ds12: %f",dis);
            
            
            MKMapPoint b11, b3,b2;
            b11.x = P1[0];
            b11.y = P1[1];
            
            b2.x = P2[0];
            b2.y = P2[1];
            
            b3.x = P3[0];
            b3.y = P3[1];
            
            
            MKMapPoint bcp;
            bcp.x = 74500353.815189;
            bcp.y = 99520188.663460;
            
            double discp1 = MKMetersBetweenMapPoints(bcp, b11);
            
            NSLog(@"discp1: %f",discp1);
            
            
            double discp2 = MKMetersBetweenMapPoints(bcp, b2);
            
            NSLog(@"discp2: %f",discp2);
            
            double discp3 = MKMetersBetweenMapPoints(bcp, b3);
            
            NSLog(@"discp3: %f",discp3);
            
            
            for (NSUInteger i = 0; i < 3; i++) {
                ex[i] = (P2[i]- P1[i]) / sqrt(P2P1);
            }
            
            // i = dot(ex, P3 - P1)
            double p3p1[] = { 0, 0, 0};
            
            for (NSUInteger i = 0; i < 3; i++) {
                p3p1[i] = P3[i]- P1[i];
            }
            
            double ivar = 0;
            
            for (NSUInteger i = 0; i < 3; i++) {
                ivar += (ex[i] * p3p1[i]);
            }
            
            // ey = (P3 - P1 - i*ex)/(numpy.linalg.norm(P3 - P1 - i*ex))
            double p3p1i = 0;
            
            for (NSUInteger  i = 0; i < 3; i++) {
                p3p1i += pow(P3[i]- P1[i] - ex[i] * ivar, 2);
            }
            
            double ey[] = { 0, 0, 0};
            
            for (NSUInteger i = 0; i < 3; i++) {
                ey[i] = (P3[i]- P1[i] - ex[i] * ivar) / sqrt(p3p1i);
            }
            
            // ez = numpy.cross(ex,ey)
            // if 2-dimensional vector then ez = 0
            double ez[] = { 0, 0, 0};
            
//            ez[0]= (ex[1] * ey[2]) - (ex[2]*ey[1]);
//            ez[1]= (ex[2] * ey[0]) - (ex[0]*ey[2]);
//            ez[2]= (ex[0] * ey[1]) - (ex[1]*ey[0]);
            
            
            // d = numpy.linalg.norm(P2 - P1)
            double d = sqrt(P2P1);
            
            // j = dot(ey, P3 - P1)
            double jvar = 0;
            
            for (NSUInteger i = 0; i < 3; i++) {
                jvar += (ey[i] * p3p1[i]);
            }
            
            // from wikipedia
            // plug and chug using above values
            double x = (pow(DistA, 2) - pow(DistB, 2) + pow(d, 2)) / (2 * d);
            //(pow(_distanceToA, 2) - pow(_distanceToC, 2) + pow(i, 2) + pow(j, 2)) / (2 * j) - (i * x) / j;
            double y = (pow(DistA, 2) - pow(DistC, 2) + pow(ivar, 2)
                        + pow(jvar, 2)) / (2 * jvar) - (ivar * x) /jvar;
            
            // only one case shown here
            double z = sqrt(pow(DistA, 2) - pow(x, 2) - pow(y, 2));
            
            if (isnan(z)) z = 0;
            
            // triPt is an array with ECEF x,y,z of trilateration point
            // triPt = P1 + x*ex + y*ey + z*ez
            double triPtTemp[] = { 0, 0, 0};
            
            for (NSUInteger i = 0; i < 2; i++) {
                //_pointA.x + x * eX.x + y * eY.x, _pointA.y + x * eX.y + y * eY.y
                
                triPtTemp[i] =  P1[i] + ex[i] * x + ey[i] * y + ez[i] * z;
            }
            
            // convert back to lat/long from ECEF
            // convert to degrees
            double lat = triPtTemp[0] ;
            double lon = triPtTemp[1] ;
            
            
            MKMapPoint b1 ;
            b1.x = lat;
            b1.y = lon;
            
            CLLocationCoordinate2D tempCoordinate = MKCoordinateForMapPoint(b1);
//            CLLocationCoordinate2D tempCoordinate = CLLocationCoordinate2DMake(lat, lon);
            
            // Add an annotation
            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            point.coordinate = tempCoordinate;
            point.title = @"You are Here";
            
            [self.indoorMap addAnnotation:point];
            
            NSLog(@"currentlocation:%f,%f", tempCoordinate.latitude, tempCoordinate.longitude);
//            MKMapPoint b1 = MKMapPointForCoordinate(tempCoordinate);
            
            triPt = [[NSMutableArray alloc] initWithCapacity:0];
            [triPt addObject:[NSNumber numberWithDouble:b1.x]];
            [triPt addObject:[NSNumber numberWithDouble:b1.y]];
            
            return triPt;
            
        }
//    }
    return triPt;
}



//-(NSMutableArray *)currentLocationPoint:(NSArray <CLBeacon *>*)beacons
//{
//    // dist im miles : ([self calculateAccuracyWithRssi:abeacon.rssi forMinor:abeacon.minor]/1000) * 1.609344;
//    // mi = m * 0.00062137
//
//    NSMutableArray *triPt;
//    NSString *error = @"";
//
////    if ([KTKBeaconManager isMonitoringAvailable]) {
//
//        if (beacons.count == 3)
//        {
//            float DistA, DistB, DistC;
//            float xA, yA, zA , xB, yB, zB , xC, yC, zC;
//            float R = 6371;
//            for (NSUInteger i = 0; i < beacons.count; i++)
//            {
//                NSString *filePath = [[NSBundle mainBundle] pathForResource:@"TheBeacons" ofType:@"plist"];
//                
//                NSDictionary *properties = [NSDictionary dictionaryWithContentsOfFile:filePath];
//                
//                CLBeacon *abeacon = [beacons objectAtIndex:i];
//                NSString *key = [NSString stringWithFormat:@"%@", abeacon.minor];
//                CGPoint tempPoint = CGPointFromString(properties[key]);
//                CLLocationCoordinate2D tempCoordinate = CLLocationCoordinate2DMake(tempPoint.x, tempPoint.y);
//                if (i == 0) {
//                    DistA =  ([self calculateAccuracyWithRssi:abeacon.rssi forMinor:abeacon.minor]/1000) ;
//                    xA = R * (cos((tempCoordinate.latitude * M_PI/180))* cos((tempCoordinate.longitude * M_PI/180)));
//                    yA = R * (cos((tempCoordinate.latitude * M_PI/180))* sin((tempCoordinate.longitude * M_PI/180)));
//                    zA = R * (sin(tempCoordinate.latitude * M_PI/180));
//                    
//                    
////                    // Add an annotation
////                    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
////                    point.coordinate = tempCoordinate;
////                    point.title = @"First";
////                    [self.indoorMap addAnnotation:point];
//                    NSLog(@"first:%f,%f", tempCoordinate.latitude, tempCoordinate.longitude);
//                    
//                }
//                
//                if (i == 1) {
//                    DistB = ([self calculateAccuracyWithRssi:abeacon.rssi forMinor:abeacon.minor]/1000);
//                    
//                    xB = R * (cos((tempCoordinate.latitude * M_PI/180))* cos((tempCoordinate.longitude * M_PI/180)));
//                    yB = R * (cos((tempCoordinate.latitude * M_PI/180))* sin((tempCoordinate.longitude * M_PI/180)));
//                    zB = R * (sin(tempCoordinate.latitude * M_PI/180));
////                    // Add an annotation
////                    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
////                    point.coordinate = tempCoordinate;
////                    point.title = @"Second";
////                    [self.indoorMap addAnnotation:point];
//                    NSLog(@"second:%f,%f", tempCoordinate.latitude, tempCoordinate.longitude);
//                    
//                }
//                
//                if (i == 2) {
//                    DistC = ([self calculateAccuracyWithRssi:abeacon.rssi forMinor:abeacon.minor]/1000);
//                    
//                    xC = R * (cos((tempCoordinate.latitude * M_PI/180))* cos((tempCoordinate.longitude * M_PI/180)));
//                    yC = R * (cos((tempCoordinate.latitude * M_PI/180))* sin((tempCoordinate.longitude * M_PI/180)));
//                    zC = R * (sin(tempCoordinate.latitude * M_PI/180));
//                    
////                    // Add an annotation
////                    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
////                    point.coordinate = tempCoordinate;
////                    point.title = @"Third";
////                    [self.indoorMap addAnnotation:point];
////                    NSLog(@"third:%f,%f", tempCoordinate.latitude, tempCoordinate.longitude);
//                    
//                }
//                
//            }
//            NSLog(@"distA:@%f",DistA);
//            NSLog(@"distB:@%f",DistB);
//            NSLog(@"distC:@%f",DistC);
//            
//            NSMutableArray *P1,*P2,*P3;
//            
//            //P1,P2,P3 is the point and 2-dimension vector
//            P1 = [[NSMutableArray alloc] initWithCapacity:0];
//            [P1 addObject:[NSNumber numberWithFloat:xA]];
//            [P1 addObject:[NSNumber numberWithFloat:yA]];
//            [P1 addObject:[NSNumber numberWithFloat:zA]];
//            
//            P2 = [[NSMutableArray alloc] initWithCapacity:0];
//            [P2 addObject:[NSNumber numberWithFloat:xB]];
//            [P2 addObject:[NSNumber numberWithFloat:yB]];
//            [P2 addObject:[NSNumber numberWithFloat:zB]];
//            
//            P3 = [[NSMutableArray alloc] initWithCapacity:0];
//            [P3 addObject:[NSNumber numberWithFloat:xC]];
//            [P3 addObject:[NSNumber numberWithFloat:yC]];
//            [P3 addObject:[NSNumber numberWithFloat:zC]];
//            
//            // transform to get circle 1 at origin
//            // transform to get circle 2 on x axis
//            
//            // ex = (P2 - P1)/(numpy.linalg.norm(P2 - P1))
//            
//            
//            
//            
////            2016-04-27 22:08:09.133 IndoorMappingiOS[851:285452] first:42.126956,-80.087147
////            2016-04-27 22:08:09.133 IndoorMappingiOS[851:285452] second:42.127055,-80.087182
////
//            CLLocationCoordinate2D tempCoordinate11 = CLLocationCoordinate2DMake(42.126956, -80.087147);
//            
//            CLLocationCoordinate2D tempCoordinate22 = CLLocationCoordinate2DMake(42.127055, -80.087182);
//            
//            MKMapPoint b133 = MKMapPointForCoordinate(tempCoordinate11);
//            
//            MKMapPoint b144 = MKMapPointForCoordinate(tempCoordinate22);
//            
//                        double dis = MKMetersBetweenMapPoints(b133, b144);
//            
//                        NSLog(@"ds12: %f",dis);
//            
//            
//            
//            double ex[] = { 0, 0, 0 };
//            double P2P1 = 0;
//            
//            for (NSUInteger i = 0; i < 3; i++) {
//                P2P1 += pow([[P2 objectAtIndex:i] doubleValue] - [[P1 objectAtIndex:i] doubleValue], 2);
//            }
//            
//            for (NSUInteger i = 0; i < 3; i++) {
//                ex[i] = ([[P2 objectAtIndex:i] doubleValue] - [[P1 objectAtIndex:i] doubleValue]) / sqrt(P2P1);
//            }
//            
//            // i = dot(ex, P3 - P1)
//            double p3p1[] = { 0, 0, 0 };
//            
//            for (NSUInteger i = 0; i < 3; i++) {
//                p3p1[i] = [[P3 objectAtIndex:i] doubleValue] - [[P1 objectAtIndex:i] doubleValue];
//            }
//            
//            double ivar = 0;
//            
//            for (NSUInteger i = 0; i < 3; i++) {
//                ivar += (ex[i] * p3p1[i]);
//            }
//            
//            // ey = (P3 - P1 - i*ex)/(numpy.linalg.norm(P3 - P1 - i*ex))
//            double p3p1i = 0;
//            
//            for (NSUInteger  i = 0; i < 3; i++) {
//                p3p1i += pow([[P3 objectAtIndex:i] doubleValue] - [[P1 objectAtIndex:i] doubleValue] - ex[i] * ivar, 2);
//            }
//            
//            double ey[] = { 0, 0, 0};
//            
//            for (NSUInteger i = 0; i < 3; i++) {
//                ey[i] = ([[P3 objectAtIndex:i] doubleValue] - [[P1 objectAtIndex:i] doubleValue] - ex[i] * ivar) / sqrt(p3p1i);
//            }
//            
//            // ez = numpy.cross(ex,ey)
//            // if 2-dimensional vector then ez = 0
//            double ez[] = { 0, 0, 0 };
//            
//            // d = numpy.linalg.norm(P2 - P1)
//            double d = sqrt(P2P1);
//            
//            // j = dot(ey, P3 - P1)
//            double jvar = 0;
//            
//            for (NSUInteger i = 0; i < 3; i++) {
//                jvar += (ey[i] * p3p1[i]);
//            }
//            
//            // from wikipedia
//            // plug and chug using above values
//            double x = (pow(DistA, 2) - pow(DistB, 2) + pow(d, 2)) / (2 * d);
//            double y = ((pow(DistA, 2) - pow(DistC, 2) + pow(ivar, 2)
//                         + pow(jvar, 2)) / (2 * jvar)) - ((ivar / jvar) * x);
//            
//            // only one case shown here
//            double z = sqrt(pow(DistA, 2) - pow(x, 2) - pow(y, 2));
//            
//            if (isnan(z)) z = 0;
//            
//            // triPt is an array with ECEF x,y,z of trilateration point
//            // triPt = P1 + x*ex + y*ey + z*ez
//            double triPtTemp[] = { 0, 0, 0 };
//            
//            for (NSUInteger i = 0; i < 3; i++) {
//                triPtTemp[i] =  [[P1 objectAtIndex:i] doubleValue] + ex[i] * x + ey[i] * y + ez[i] * z;
//            }
//            
//            // convert back to lat/long from ECEF
//            // convert to degrees
//            double lat = (asin(triPtTemp[2]/ R)) * 180 / M_PI;
//            double lon = (atan2(triPtTemp[1],triPtTemp[0]))* 180 / M_PI;
//            
//            
//            CLLocationCoordinate2D tempCoordinate = CLLocationCoordinate2DMake(lat, lon);
//            
//            // Add an annotation
//            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//            point.coordinate = tempCoordinate;
//            point.title = @"You are Here";
//            
//            [self.indoorMap addAnnotation:point];
//            
//            NSLog(@"currentlocation:%f,%f", tempCoordinate.latitude, tempCoordinate.longitude);
//            MKMapPoint b1 = MKMapPointForCoordinate(tempCoordinate);
//            
//            triPt = [[NSMutableArray alloc] initWithCapacity:0];
//            [triPt addObject:[NSNumber numberWithDouble:b1.x]];
//            [triPt addObject:[NSNumber numberWithDouble:b1.y]];
//            
//            return triPt;
//            
//        }
////    }
//    return triPt;
//}




-(double)calculateMKMetersBetweenMapPoints:(MKMapPoint )mapPointFrom toPoint:(MKMapPoint)mapPointTo
{

    CLLocationCoordinate2D toCoord = MKCoordinateForMapPoint(mapPointTo);
    //
//    NSLog(@"currentlocation:%f,%f", toCoord.latitude, toCoord.longitude);
    
    double dis = MKMetersBetweenMapPoints(mapPointFrom, mapPointTo);
    
    return dis;
    
    
    //https://rosettacode.org/wiki/Haversine_formula
//    CLLocationCoordinate2D fromCoord = MKCoordinateForMapPoint(mapPointFrom);
//    CLLocationCoordinate2D toCoord = MKCoordinateForMapPoint(mapPointTo);
//
//    NSLog(@"currentlocation:%f,%f", toCoord.latitude, toCoord.longitude);
//    NSLog(@"pointClass:%f,%f", fromCoord.latitude, fromCoord.longitude);
//    //degrees to radians
//    double lat1rad = fromCoord.latitude * M_PI/180;
//    double lon1rad = fromCoord.longitude * M_PI/180;
//    double lat2rad = toCoord.longitude * M_PI/180;
//    double lon2rad = toCoord.longitude * M_PI/180;
//    
//    //deltas
//    double dLat = lat2rad - lat1rad;
//    double dLon = lon2rad - lon1rad;
//    
//    double a = sin(dLat/2) * sin(dLat/2) + sin(dLon/2) * sin(dLon/2) * cos(lat1rad) * cos(lat2rad);
//    double c = 2 * asin(sqrt(a));
//    double R = 6372.8;
//    double dis = R * c;
    // 0.0010000 k to m
//    dis = dis/1000;
//    return dis;


    
}

-(void)findMinDistince:(MKMapPoint)mapPointFrom
{
    
    NSMutableArray *originalarray = [self dicRoomPoints];
    
    NSMutableDictionary *tempdic = [[NSMutableDictionary alloc]
                                    init];
    
    
    NSUInteger count = [originalarray count];
    for (NSUInteger index = 0; index < count ; index++) {
        
        NSMutableDictionary *old = [originalarray objectAtIndex:index];
        
        NSString *key = [[old allKeys] objectAtIndex:0];
        
        
        NSValue *pointValue = [old objectForKey:key];

        MKMapPoint pointtem;
        
        [pointValue getValue:&pointtem];
        
        double dist = [self calculateMKMetersBetweenMapPoints:pointtem toPoint:mapPointFrom];
        
        NSValue *doubledist = [NSValue value:&dist withObjCType:@encode(double)];
        
        [tempdic setObject:doubledist forKey:key];
        
    }
    
    
    [self sortNearestRoom:tempdic];
    
}

-(void)sortNearestRoom:(NSMutableDictionary*) myDictRooms

{
    NSString *nearestRoom;
    double min;
    min = 0.0;
    
    NSUInteger count = [myDictRooms count];
    for (NSUInteger index = 0; index < count ; index++) {
        // iterate through the dict
        
        NSString *key = [[myDictRooms allKeys] objectAtIndex:index];
        
        
        NSValue *distanceValue = [myDictRooms objectForKey:key];
        
        double distance;
        [distanceValue getValue:&distance];
        
        
        if (min == 0.0 || distance < min) {
            
            min = distance;
            nearestRoom = key;
        }
    }

    NSLog(@"the nearestroom %@", nearestRoom);

    
    self.currentLocationField.text = [@"the nearestroom is " stringByAppendingString:nearestRoom];
}

-(NSMutableArray * )dicRoomPoints
{
    // predefined positions of classrooms

    NSArray *roomKeys = [[NSArray alloc]initWithObjects:@"z313", @"z311", @"z309", @"z307",@"z305", @"z303",@"z301", @"z314",@"z312", @"z310",@"z308", @"z306", @"z304", @"z302",@"z336", @"z330",@"z329",@"z337",@"z338",@"z340",@"z341",@"z339",@"z335",@"z344",@"z345",@"z343", nil];
    
    
    
    // 313 pointx: 74500682.678342 pointy:99519905.410713
    
    MKMapPoint z313;
    
    z313.x = 74500682.678342;
    z313.y = 99519905.410713;
    
    NSValue *zz313 = [NSValue value:&z313 withObjCType:@encode(MKMapPoint)];
    
    // 311 pointx: 74500647.185104 pointy:99519924.340440
    MKMapPoint z311;
    
    z311.x = 74500647.185104;
    z311.y = 99519924.340440;
    
    NSValue *zz311 = [NSValue value:&z311 withObjCType:@encode(MKMapPoint)];
    
    // 309 pointx: 74500623.522945 pointy:99519936.171519
    MKMapPoint z309;
    
    z309.x = 74500623.522945;
    z309.y = 99519936.171519;
    
    NSValue *zz309 = [NSValue value:&z309 withObjCType:@encode(MKMapPoint)];
    
    // 307 pointx: 74500603.410110 pointy:99519948.002599
    MKMapPoint z307;
    
    z307.x = 74500603.410110;
    z307.y = 99519948.002599;
    
    NSValue *zz307 = [NSValue value:&z307 withObjCType:@encode(MKMapPoint)];
    
    // 305 pointx: 74500578.564843 pointy:99519959.833678
    
    MKMapPoint z305;
    
    z305.x = 74500578.564843;
    z305.y = 99519959.833678;
    
    NSValue *zz305 = [NSValue value:&z305 withObjCType:@encode(MKMapPoint)];
    
    // 303 pointx: 74500557.268900 pointy:99519969.298542
    
    MKMapPoint z303;
    
    z303.x = 74500557.268900;
    z303.y = 99519969.298542;
    
    NSValue *zz303 = [NSValue value:&z303 withObjCType:@encode(MKMapPoint)];
    // 301 pointx: 74500527.691201 pointy:99519987.045161
    MKMapPoint z301;
    
    z301.x = 74500527.691201;
    z301.y = 99519987.045161;
    
    NSValue *zz301 = [NSValue value:&z301 withObjCType:@encode(MKMapPoint)];
    
    // 314 pointx: 74500703.974285 pointy:99519970.481650
    
    MKMapPoint z314;
    
    z314.x = 74500703.974285;
    z314.y = 99519970.481650;
    
    NSValue *zz314 = [NSValue value:&z314 withObjCType:@encode(MKMapPoint)];
    
    // 312 pointx: 74500679.129019 pointy:99519985.862053
    
    MKMapPoint z312;
    
    z312.x = 74500679.129019;
    z312.y = 99519985.862053;
    
    NSValue *zz312 = [NSValue value:&z312 withObjCType:@encode(MKMapPoint)];
    
    // 310 pointx: 74500655.466860 pointy:99519998.876240
    
    MKMapPoint z310;
    
    z310.x = 74500655.466860;
    z310.y = 99519998.876240;
    
    NSValue *zz310 = [NSValue value:&z310 withObjCType:@encode(MKMapPoint)];
    // 308 pointx: 74500632.987809 pointy:99520007.157996
    MKMapPoint z308;
    
    z308.x = 74500632.987809;
    z308.y = 99520007.157996;
    
    NSValue *zz308 = [NSValue value:&z308 withObjCType:@encode(MKMapPoint)];
    
    // 306 pointx: 74500610.508758 pointy:99520021.355291
    MKMapPoint z306;
    
    z306.x = 74500610.508758;
    z306.y = 99520021.355291;
    
    
    NSValue *zz306 = [NSValue value:&z306 withObjCType:@encode(MKMapPoint)];
    // 304 pointx: 74500589.212815 pointy:99520030.820155
    
    MKMapPoint z304;
    
    z304.x = 74500589.212815;
    z304.y = 99520030.820155;
    
    NSValue *zz304 = [NSValue value:&z304 withObjCType:@encode(MKMapPoint)];
    
    // 302  pointx: 74500562.001332 pointy:99520048.566774
    
    MKMapPoint z302;
    
    z302.x = 74500562.001332;
    z302.y = 99520048.566774;
    
    NSValue *zz302 = [NSValue value:&z302 withObjCType:@encode(MKMapPoint)];
    
    // 336 pointx: 74500390.450680 pointy:99520140.849193
    MKMapPoint z336;
    
    z336.x = 74500390.450680;
    z336.y = 99520140.849193;
    
//    z336.x = 74500368.531213;
//    z336.y = 99520135.942804;
    
    NSValue *zz336 = [NSValue value:&z336 withObjCType:@encode(MKMapPoint)];
    
    // 330 pointx: 74500364.422305 pointy:99520035.552586
    MKMapPoint z330;
    
    z330.x = 74500364.422305;
    z330.y = 99520035.552586;
    
    NSValue *zz330 = [NSValue value:&z330 withObjCType:@encode(MKMapPoint)];
    
    // 329 pointx: 74500256.759482 pointy:99520092.341767
    MKMapPoint z329;
    z329.x = 74500256.759482;
    z329.y = 99520092.341767;
//    z329.x = 74500301.717583;
//    z329.y = 99520123.102574;
    
    NSValue *zz329 = [NSValue value:&z329 withObjCType:@encode(MKMapPoint)];
    
    // 337 pointx: 74500314.731771 pointy:99520209.469454
    MKMapPoint z337;
    
    z337.x = 74500314.731771;
    z337.y = 99520209.469454;
    
    NSValue *zz337 = [NSValue value:&z337 withObjCType:@encode(MKMapPoint)];
    
    // 338 pointx: 74500412.929731 pointy:99520185.807295
    MKMapPoint z338;
    
    z338.x = 74500412.929731;
    z338.y = 99520185.807295;
    
    NSValue *zz338 = [NSValue value:&z338 withObjCType:@encode(MKMapPoint)];
    
    // 340 pointx: 74500480.366883 pointy:99520270.991067
    MKMapPoint z340;
    
    z340.x = 74500480.366883;
    z340.y = 99520270.991067;
    
    NSValue *zz340 = [NSValue value:&z340 withObjCType:@encode(MKMapPoint)];
    
    
    // 341 pointx: 74500388.084464 pointy:99520346.709975
    MKMapPoint z341;
    
    z341.x = 74500388.084464;
    z341.y = 99520346.709975;
    
    
    NSValue *zz341 = [NSValue value:&z341 withObjCType:@encode(MKMapPoint)];
    // 339 pointx: 74500299.351368 pointy:99520384.569429
    MKMapPoint z339;
    
    z339.x = 74500299.351368;
    z339.y = 99520384.569429;
    
    NSValue *zz339 = [NSValue value:&z339 withObjCType:@encode(MKMapPoint)];
    
    // 335 pointx: 74500234.280431 pointy:99520255.610663
    MKMapPoint z335;
    
    z335.x = 74500234.280431;
    z335.y = 99520255.610663;
    
    NSValue *zz335 = [NSValue value:&z335 withObjCType:@encode(MKMapPoint)];
    
    // 344 pointx: 74500546.620929 pointy:99520410.597804
    MKMapPoint z344;
    
    z344.x = 74500546.620929;
    z344.y = 99520410.597804;
    
    NSValue *zz344 = [NSValue value:&z344 withObjCType:@encode(MKMapPoint)];
    
    // 345 pointx: 74500420.028378 pointy:99520480.401172
    MKMapPoint z345;
    
    z345.x = 74500420.028378;
    z345.y = 99520480.401172;
    
    NSValue *zz345 = [NSValue value:&z345 withObjCType:@encode(MKMapPoint)];
    
    // 343 pointx: 74500341.943254 pointy:99520519.443734
    MKMapPoint z343;
    
    z343.x = 74500341.943254;
    z343.y = 99520519.443734;
    
    NSValue *zz343 = [NSValue value:&z343 withObjCType:@encode(MKMapPoint)];
    
    NSArray  * roomsArray = [[NSArray alloc]initWithObjects:zz313,zz311,zz309,zz307,zz305,zz303,zz301,zz314,zz312,zz310, zz308,zz306,zz304,zz302,zz336,zz330,zz329,zz337,zz338,zz340, zz341,zz339,zz335,zz344,zz345,zz343, nil];
                          
    NSMutableArray *roomsArrayOfDictionary = [[NSMutableArray alloc] initWithCapacity:0];
                          
    
    NSUInteger count = [roomKeys count];
    for (NSUInteger index = 0; index < count ; index++) {
        NSMutableDictionary *roomsDictionary = [[ NSMutableDictionary alloc]
                                                init];
        [roomsDictionary setObject:[roomsArray objectAtIndex:index] forKey:[roomKeys objectAtIndex:index]];
        [roomsArrayOfDictionary addObject:roomsDictionary];
    }
    
    return roomsArrayOfDictionary;

}


-(double)calculateAccuracyWithRssi:(double)rssi forMinor:(NSNumber*)minor  {
    
    double calibratedRSSI = 0.0;
    double newCalibratedRSSI = 0.0;
    
    if(minor){
        
        
        if (minor.intValue == 1 )
        {
            calibratedRSSI = 71.1;
            //        71.1
            //        78.9   with 30 m away
        }
        
        if (minor.intValue == 2 )
        {
            calibratedRSSI = 67.7;
        }
        
        if (minor.intValue == 3 )
        {
            calibratedRSSI = 71.0;
        }
        
        
        if (minor.intValue == 4 )
        {
            calibratedRSSI = 70.2;
        }
        
        
        if (minor.intValue == 5 )
        {
            calibratedRSSI = 71.3;
        }
        
        // device off
        if (minor.intValue == 6 )
        {
            calibratedRSSI = 77.0;
        }
        
        
        if (minor.intValue == 7 )
        {
            calibratedRSSI = 70.7;
        }
    }
    
    if (rssi == 0) {
        return -1.0; // if we cannot determine accuracy, return -1.
    }
    
    //value = txPower * pow((d - .111)/ (0.89976), (1/7.7095));
    
    //    double value = 4 * pow((30 - .111)/ (0.89976), (1/7.7095));
    
//    newCalibratedRSSI = rssi * (11.8165 / calibratedRSSI);
//    
//    double ratio = newCalibratedRSSI*1.0/-12;
//    if (ratio < 1.0) {
//        return pow(ratio,10);
//    }
//    else {
//        double accuracy =  (0.89976)*pow(ratio,7.7095) + 0.111;
//        
//        return accuracy;
//    }
    
    
    
    /*
     * RSSI = TxPower - 10 * n * lg(d)
     * n = 2 (in free space)
     *
     * d = 10 ^ ((TxPower - RSSI) / (10 * n))
     */
    double accuracy = pow(10, (- calibratedRSSI - rssi) / (10 * 2));
    
    return accuracy;
    
    
//    
//    double ratio = - calibratedRSSI - rssi;
//    double ratio_linear = pow(10,ratio/10);
//    
//    
//    double accuracy =  sqrt(ratio_linear);
//    
//    return accuracy;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Detect touch anywhere
    UITouch *touch = [touches anyObject];
    
    // Get the speci]fic point that was touched
    //CGPoint point = [touch locationInView:self.view];
    
    CGPoint point = [touch locationInView:self.indoorMap];
    
    CLLocationCoordinate2D coord = [self.indoorMap convertPoint:point toCoordinateFromView:self.indoorMap];
    
    NSLog(@"lat:%f long:%f", coord.latitude, coord.longitude);
    
    MKMapPoint coord2Point = MKMapPointForCoordinate(coord);
    
        NSLog(@"pointx: %f pointy:%f", coord2Point.x, coord2Point.y);
    
    // See if the point touched is within these rectangular bounds
    if (MKMapRectContainsPoint(self.building.overlayBoundingMapRect, coord2Point))
    {
        //        NSLog(@"inside the building pointx: %f pointy:%f", coord2Point.x, coord2Point.y);
    }
    
    else
    {
        
        //        NSLog(@"Naaaah, outside");
        
        
    }
}


@end
