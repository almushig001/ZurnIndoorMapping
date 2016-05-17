//
//  AppDelegate.h
//  IndoorMappingiOS
//
//  Created by Alotaibi, Waleed N on 11/6/15.
//  Copyright © 2015 Alotaibi, Waleed N. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KontaktSDK/KontaktSDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, KTKBeaconManagerDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

