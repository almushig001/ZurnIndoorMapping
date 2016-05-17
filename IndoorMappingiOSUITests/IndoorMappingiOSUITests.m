//
//  IndoorMappingiOSUITests.m
//  IndoorMappingiOSUITests
//
//  Created by Alotaibi, Waleed N on 11/6/15.
//  Copyright © 2015 Alotaibi, Waleed N. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <OCHamcrestIOS/OCHamcrestIOS.h>
#import <OCMockitoIOS/OCMockitoIOS.h>
#import "ViewController.h"
@interface IndoorMappingiOSUITests : XCTestCase

@end

@implementation IndoorMappingiOSUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//- (void)testExample {
//    // Use recording to get started writing UI tests.
//    // Use XCTAssert and related functions to verify your tests produce the correct results.
//    
//    XCUIApplication *app = [[XCUIApplication alloc] init];
//    XCUIElement *indoormappingiosIcon = app.scrollViews.otherElements.icons[@"IndoorMappingiOS"];
//    [indoormappingiosIcon tap];
//    [app.alerts[@"Allow \U201cIndoorMappingiOS\U201d to access your location while you use the app?"].collectionViews.buttons[@"Allow"] tap];
//    [indoormappingiosIcon tap];
//    [indoormappingiosIcon tap];
//    
//}
- (void)testExample{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *map = [[[[[[[[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"Indoor Map"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeMap].element;
    [map tap];
    [map tap];
    [map tap];
    [app.navigationBars[@"Indoor Map"].buttons[@"Refresh"] tap];
    
}
- (void)testLocation{
    [[[[[[[[[[[XCUIApplication alloc] init].otherElements containingType:XCUIElementTypeNavigationBar identifier:@"Indoor Map"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeMap].element tap];
    [[[[[[[[[[[XCUIApplication alloc] init].otherElements containingType:XCUIElementTypeNavigationBar identifier:@"Indoor Map"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeMap].element tap];
    [[[[[[[[[[[XCUIApplication alloc] init].otherElements containingType:XCUIElementTypeNavigationBar identifier:@"Indoor Map"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeMap].element tap];
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [[[[[[[[[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"Indoor Map"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeMap].element tap];
    [app.navigationBars[@"Indoor Map"].buttons[@"Refresh"] tap];
    
    
}
-(void)testSetRegion{
    [[[[[[[[[[[XCUIApplication alloc] init].otherElements containingType:XCUIElementTypeNavigationBar identifier:@"Indoor Map"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeMap].element tap];
    
    
    XCUIElement *map = [[[[[[[[[[XCUIApplication alloc] init].otherElements containingType:XCUIElementTypeNavigationBar identifier:@"Indoor Map"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeMap].element;
    [map tap];
    [map tap];
    
    [[[[[[[[[[[XCUIApplication alloc] init].otherElements containingType:XCUIElementTypeNavigationBar identifier:@"Indoor Map"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeMap].element tap];
    
    
    
    [[[[[[[[[[[XCUIApplication alloc] init].otherElements containingType:XCUIElementTypeNavigationBar identifier:@"Indoor Map"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeMap].element tap];
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [[[[[[[[[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"Indoor Map"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeMap].element tap];
    [app.navigationBars[@"Indoor Map"].buttons[@"Refresh"] tap];
    
}
-(void)testSwipLeft{
    
    XCUIElement *map = [[[[[[[[[[XCUIApplication alloc] init].otherElements containingType:XCUIElementTypeNavigationBar identifier:@"Indoor Map"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeMap].element;
    [map swipeRight];
    [map tap];
    
    
}
-(void)testSwipRight{
    
    XCUIElement *map = [[[[[[[[[[XCUIApplication alloc] init].otherElements containingType:XCUIElementTypeNavigationBar identifier:@"Indoor Map"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeMap].element;
    [map tap];
    [map tap];
    
    
}
-(void)testSwipUp{
    
    XCUIElement *map = [[[[[[[[[[XCUIApplication alloc] init].otherElements containingType:XCUIElementTypeNavigationBar identifier:@"Indoor Map"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeMap].element;
    [map tap];
    [map tap];
    
    
}
-(void)testSwipDown{
    
    XCUIElement *map = [[[[[[[[[[XCUIApplication alloc] init].otherElements containingType:XCUIElementTypeNavigationBar identifier:@"Indoor Map"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeMap].element;
    [map tap];
    [map tap];
    
    
}

- (void)testcrl {
    
    
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.tables.staticTexts[@"Zurn"] tap];
    [app.buttons[@"Third"] tap];
    
    
    
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
    
//    [self.vcToTest beaconManager:self.vcToTest.beaconManager didRangeBeacons:@[mockBeacon3, mockBeacon2, mockBeacon1]
//                        inRegion:mockRegion];
}

@end
