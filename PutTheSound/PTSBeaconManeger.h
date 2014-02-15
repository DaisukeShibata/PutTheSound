//
//  PTSBeaconManeger.h
//  PutTheSound
//
//  Created by Daisuke Shibata on 2014/02/15.
//  Copyright (c) 2014年 Toshiki Chiba. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@protocol PTSBeaconManegerDelegate <NSObject>
-(void)localNotification:(long)trackID;
@end

@interface PTSBeaconManeger : NSObject<CLLocationManagerDelegate, CBPeripheralManagerDelegate>

@property(nonatomic, assign)id<PTSBeaconManegerDelegate> _delegate;

- (void)startAdvertising:(double)trackID;
-(void)setupManagerWithDelegate:(id)delegate;
+ (PTSBeaconManeger *)sharedManager;

@end
