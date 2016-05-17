//
//  MapOverlayView.h
//  IndoorMappingiOS
//
//  Created by Hadeel Almushigih on 12/5/15.
//  Copyright © 2015 Alotaibi, Waleed N. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Building.h"

@interface MapOverlayView : MKOverlayRenderer

- (instancetype)initWithOverlay:(id<MKOverlay>)overlay withBuilding:(Building *)building;

@property (nonatomic, strong) Building *building;
@end
