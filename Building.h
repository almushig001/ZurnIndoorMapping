//
//  Building.h
//  IndoorMappingiOS
//
//  Created by Almushigih, Hadeel on 12/5/15.
//  Copyright © 2015 Alotaibi, Waleed N. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface Building : NSObject

@property (nonatomic, readonly) MKMapRect overlayBoundingMapRect;

@property (nonatomic, readonly) MKMapRect a314;

@property (nonatomic, readonly) MKMapRect aHallway;

@property (nonatomic, readonly) CLLocationCoordinate2D centerCoord;

@property (nonatomic, readonly) CLLocationCoordinate2D overlayTopLeftCoordinate;

@property (nonatomic, readonly) CLLocationCoordinate2D overlayTopRightCoordinate;

@property (nonatomic, readonly) CLLocationCoordinate2D overlayBottomLeftCoordinate;

@property (nonatomic, readonly) CLLocationCoordinate2D overlayBottomRightCoordinate;

@property (nonatomic, retain) NSString* buildingName;

@property (nonatomic, retain) NSString* floorNum;

- (instancetype)initWithName:(NSString *)name;

@end
