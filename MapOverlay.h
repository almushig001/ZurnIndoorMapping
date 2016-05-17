//
//  MapOverlay.h
//  IndoorMappingiOS
//
//  Created by Almushigih, Hadeel on 12/5/15.
//  Copyright © 2015 Alotaibi, Waleed N. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Building.h"

@interface MapOverlay : NSObject <MKOverlay>

- (instancetype)initWithBuilding:(Building *)building ;
@end
