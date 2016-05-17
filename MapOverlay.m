//
//  MapOverlay.m
//  IndoorMappingiOS
//
//  Created by Almushigih, Hadeel on 12/5/15.
//  Copyright © 2015 Alotaibi, Waleed N. All rights reserved.
//

#import "MapOverlay.h"

@implementation MapOverlay

@synthesize coordinate;
@synthesize boundingMapRect;


- (instancetype)initWithBuilding:(Building *)building {
    self = [super init];
    if (self) {
        boundingMapRect = building.overlayBoundingMapRect;
        coordinate = building.centerCoord;
    }
    
    return self;
}


@end
