//
//  Building.m
//  IndoorMappingiOS
//
//  Created by Almushigih, Hadeel on 12/5/15.
//  Copyright © 2015 Alotaibi, Waleed N. All rights reserved.
//

#import "Building.h"

@implementation Building

- (instancetype)initWithName:(NSString *)name {
    
    self = [super init];
    
    if (self) {
        
        _buildingName = name;
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
        
        NSDictionary *properties = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        CGPoint midPoint = CGPointFromString(properties[@"centerCoord"]);
        
        _centerCoord = CLLocationCoordinate2DMake(midPoint.x, midPoint.y);
        
        CGPoint overlayTopLeftPoint = CGPointFromString(properties[@"overlayTopLeftCoord"]);
        
        _overlayTopLeftCoordinate = CLLocationCoordinate2DMake(overlayTopLeftPoint.x, overlayTopLeftPoint.y);
        
        CGPoint overlayTopRightPoint = CGPointFromString(properties[@"overlayTopRightCoord"]);
        
        _overlayTopRightCoordinate = CLLocationCoordinate2DMake(overlayTopRightPoint.x, overlayTopRightPoint.y);

        CGPoint overlayBottomLeftPoint = CGPointFromString(properties[@"overlayBottomLeftCoord"]);
        
        _overlayBottomLeftCoordinate = CLLocationCoordinate2DMake(overlayBottomLeftPoint.x, overlayBottomLeftPoint.y);
        
        CGPoint overlayBottomRightPoint = CGPointFromString(properties[@"overlayBottomRightCoord"]);
        
        _overlayBottomLeftCoordinate = CLLocationCoordinate2DMake(overlayBottomRightPoint.x, overlayBottomRightPoint.y);
        
    }
    
    return self;
    
}

- (MKMapRect)overlayBoundingMapRect {
    MKMapPoint topLeft = MKMapPointForCoordinate(self.overlayTopLeftCoordinate);
    MKMapPoint topRight = MKMapPointForCoordinate(self.overlayTopRightCoordinate);
    MKMapPoint bottomLeft = MKMapPointForCoordinate(self.overlayBottomLeftCoordinate);
    
    return MKMapRectMake(topLeft.x,
                         topLeft.y,
                         fabs(topLeft.x - topRight.x),
                         fabs(topLeft.y - bottomLeft.y));
    
    
}

- (MKMapRect)a314 {
    
    return MKMapRectMake(74500678.601613,
                         99519963.934028,
                         fabs(74500678.601613 - 74500711.606304),
                         fabs(99519963.934028 - 99519998.687667));
}


- (MKMapRect)aHallway {

//    return MKMapRectMake(74500315.245644,
//                         99520127.044954,
//                         fabs(74500315.245644 - 74500722.191292),
//                         fabs(99520127.044954 - 99520146.773781));
    
//    
//        return MKMapRectMake(74500315.245644,
//                             99520127.044954,
//                             fabs(99520127.044954 - 99520146.773781),
//                             fabs(74500315.245644 - 74500722.191292));
    
//    return MKMapRectMake(74500327.073996,
//                         99519911.220224,
//                         fabs(74500722.191292 - 74500327.073996),
//                         fabs(99520146.773781 - 99519911.220224));
    
//    
//    
//        return MKMapRectMake(74500327.073996,
//                             99519911.220224,(74500722.191292 - 74500327.073996),
//                             (99520146.773781 - 99519911.220224));
//    
//    return MKMapRectMake(74500315.245644,
//                         99520127.044954,
//                         fabs(74500722.191292 - 74500315.245644),
//                         fabs(99520127.044954 - 99520146.773781));
    
    return MKMapRectMake(74500315.245644,
                         99520127.044954,
                         fabs(74500315.245644 - 74500722.191292),
                         fabs(99520127.044954 - 99520146.773781));
}


@end
