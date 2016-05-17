//
//  IndoorMappingiOSTests.m
//  IndoorMappingiOSTests
//
//  Created by Almushigih, Hadeel on 29/2/16.
//  Copyright © 2016 Almushigih, Hadeel . All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCHamcrestIOS/OCHamcrestIOS.h>
#import <OCMockitoIOS/OCMockitoIOS.h>
#import "ViewController.h"

@interface IndoorMappingiOSTests : XCTestCase

@property (nonatomic) ViewController *vcToTest;
@end

@implementation IndoorMappingiOSTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
     self.vcToTest = [[ViewController alloc] init];
    [self.vcToTest viewDidLoad];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testlocationManagerDelegate {
    XCTAssertTrue(self.vcToTest.locationManager.delegate == self.vcToTest);
    
}

- (void)testbeaconManagerDelegate {
    XCTAssertTrue(self.vcToTest.beaconManager.delegate == self.vcToTest);
    
}


- (void)testcurrentLocationPoint {

//    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:@"f7826da6-4fa2-4e98-8024-bc5b71e0893e"];
    

    CLBeacon *mockBeacon1  = mock([CLBeaconRegion class]);
    mockBeacon1 = [[CLBeacon alloc] init];
    CLBeaconRegion *mockRegion  = mock([CLBeaconRegion class]);
    
//    KTKBeaconRegion *mockRegion  = self.vcToTest.region;
    
//    [mockRegion initWithProximityUUID:proximityUUID major:1 identifier:@"identifier"];
    
    [mockRegion setValue:[NSNumber numberWithInt:1] forKey:@"major"];
    [mockRegion setValue:[[NSUUID alloc] initWithUUIDString:@"f7826da6-4fa2-4e98-8024-bc5b71e0893e"] forKey:@"proximityUUID"];

    
    [mockBeacon1 setValue:[NSNumber numberWithInt:1] forKey:@"major"];
    [mockBeacon1 setValue:[NSNumber numberWithInt:1] forKey:@"minor"];
    [mockBeacon1 setValue:[NSNumber numberWithInt:-79] forKey:@"rssi"];
    [mockBeacon1 setValue:[[NSUUID alloc] initWithUUIDString:@"f7826da6-4fa2-4e98-8024-bc5b71e0893e"] forKey:@"proximityUUID"];
    NSLog(@"I constructed this iBeacon manually: %@", mockBeacon1);
    
    
    CLBeacon *mockBeacon2  = mock([CLBeaconRegion class]);
    mockBeacon2 = [[CLBeacon alloc] init];
    [mockBeacon2 setValue:[NSNumber numberWithInt:1] forKey:@"major"];
    [mockBeacon2 setValue:[NSNumber numberWithInt:2] forKey:@"minor"];
    [mockBeacon2 setValue:[NSNumber numberWithInt:-66] forKey:@"rssi"];
    [mockBeacon2 setValue:[[NSUUID alloc] initWithUUIDString:@"f7826da6-4fa2-4e98-8024-bc5b71e0893e"] forKey:@"proximityUUID"];
    NSLog(@"I constructed this iBeacon manually: %@", mockBeacon2);
    
    CLBeacon *mockBeacon3  = mock([CLBeaconRegion class]);
    mockBeacon3 = [[CLBeacon alloc] init];
    [mockBeacon3 setValue:[NSNumber numberWithInt:1] forKey:@"major"];
    [mockBeacon3 setValue:[NSNumber numberWithInt:3] forKey:@"minor"];
    [mockBeacon3 setValue:[NSNumber numberWithInt:-65] forKey:@"rssi"];
    [mockBeacon3 setValue:[[NSUUID alloc] initWithUUIDString:@"f7826da6-4fa2-4e98-8024-bc5b71e0893e"] forKey:@"proximityUUID"];
    NSLog(@"I constructed this iBeacon manually: %@", mockBeacon3);
    
    [self.vcToTest beaconManager:self.vcToTest.beaconManager didRangeBeacons:@[mockBeacon3, mockBeacon2, mockBeacon1]
                                                      inRegion:mockRegion];
    
//    [KTKBeaconManager isMonitoringAvailable = YES;
    
    
    XCTAssertNotNil(mockBeacon1);
    XCTAssertNotNil(mockBeacon2);
    XCTAssertNotNil(mockBeacon3);
    
    XCTAssertNotNil(self.vcToTest.relevantsBeacons);
    
    
    // 42.127069, -80.087240
    NSMutableArray *triPt = [self.vcToTest currentLocationPoint:self.vcToTest.relevantsBeacons];
    
    XCTAssertNotNil(triPt);
    
    if (triPt.count > 0) {
        
        
        MKMapPoint currentLocationPoint;
        
        currentLocationPoint.x = [[triPt objectAtIndex:0] doubleValue];
        currentLocationPoint.y = [[triPt objectAtIndex:1] doubleValue];
    
        XCTAssertTrue((currentLocationPoint.x == 74500353.815189) && ( currentLocationPoint.y == 99520188.663460));
    
    }
    
    NSLog(@"array: %@", triPt);
    
}


- (void)testcurrentLocationPoint2 {
    
    //    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:@"f7826da6-4fa2-4e98-8024-bc5b71e0893e"];
    
    
    CLBeacon *mockBeacon1  = mock([CLBeaconRegion class]);
    mockBeacon1 = [[CLBeacon alloc] init];
    CLBeaconRegion *mockRegion  = mock([CLBeaconRegion class]);
    
    //    KTKBeaconRegion *mockRegion  = self.vcToTest.region;
    
    //    [mockRegion initWithProximityUUID:proximityUUID major:1 identifier:@"identifier"];
    
    [mockRegion setValue:[NSNumber numberWithInt:1] forKey:@"major"];
    [mockRegion setValue:[[NSUUID alloc] initWithUUIDString:@"f7826da6-4fa2-4e98-8024-bc5b71e0893e"] forKey:@"proximityUUID"];
    
    
    [mockBeacon1 setValue:[NSNumber numberWithInt:1] forKey:@"major"];
    [mockBeacon1 setValue:[NSNumber numberWithInt:1] forKey:@"minor"];
    [mockBeacon1 setValue:[NSNumber numberWithInt:-79] forKey:@"rssi"];
    [mockBeacon1 setValue:[[NSUUID alloc] initWithUUIDString:@"f7826da6-4fa2-4e98-8024-bc5b71e0893e"] forKey:@"proximityUUID"];
    NSLog(@"I constructed this iBeacon manually: %@", mockBeacon1);
    
    
    CLBeacon *mockBeacon2  = mock([CLBeaconRegion class]);
    mockBeacon2 = [[CLBeacon alloc] init];
    [mockBeacon2 setValue:[NSNumber numberWithInt:1] forKey:@"major"];
    [mockBeacon2 setValue:[NSNumber numberWithInt:2] forKey:@"minor"];
    [mockBeacon2 setValue:[NSNumber numberWithInt:-66] forKey:@"rssi"];
    [mockBeacon2 setValue:[[NSUUID alloc] initWithUUIDString:@"f7826da6-4fa2-4e98-8024-bc5b71e0893e"] forKey:@"proximityUUID"];
    NSLog(@"I constructed this iBeacon manually: %@", mockBeacon2);
    
    CLBeacon *mockBeacon3  = mock([CLBeaconRegion class]);
    mockBeacon3 = [[CLBeacon alloc] init];
    [mockBeacon3 setValue:[NSNumber numberWithInt:1] forKey:@"major"];
    [mockBeacon3 setValue:[NSNumber numberWithInt:3] forKey:@"minor"];
    [mockBeacon3 setValue:[NSNumber numberWithInt:-65] forKey:@"rssi"];
    [mockBeacon3 setValue:[[NSUUID alloc] initWithUUIDString:@"f7826da6-4fa2-4e98-8024-bc5b71e0893e"] forKey:@"proximityUUID"];
    NSLog(@"I constructed this iBeacon manually: %@", mockBeacon3);
    
    [self.vcToTest beaconManager:self.vcToTest.beaconManager didRangeBeacons:@[mockBeacon3, mockBeacon2, mockBeacon1]
                        inRegion:mockRegion];
    
    //    [KTKBeaconManager isMonitoringAvailable = YES;
    
    
    XCTAssertNotNil(mockBeacon1);
    XCTAssertNotNil(mockBeacon2);
    XCTAssertNotNil(mockBeacon3);
    
    XCTAssertNotNil(self.vcToTest.relevantsBeacons);
    
    
    NSMutableArray *triPt = [self.vcToTest currentLocationPoint:self.vcToTest.relevantsBeacons];
    
    XCTAssertNotNil(triPt);
    
    if (triPt.count > 0) {
        
        //74500353.815189;
        //99520188.663460;
        // 42.127069, -80.087240
        
        
        MKMapPoint currentLocationPoint;
        
        currentLocationPoint.x = [[triPt objectAtIndex:0] doubleValue];
        currentLocationPoint.y = [[triPt objectAtIndex:1] doubleValue];
        
        XCTAssertFalse((currentLocationPoint.x == 74500353.815189) && ( currentLocationPoint.y == 99520188.663460));
        
    }
    
    NSLog(@"array: %@", triPt);
    
}


@end
