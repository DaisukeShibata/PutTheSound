//
//  PTSMapViewController.h
//  PutTheSound
//
//  Created by Daisuke Shibata on 2014/04/26.
//  Copyright (c) 2014年 Toshiki Chiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YMapKit/YMapKit.h>

@interface PTSMapViewController : UIViewController<YMKMapViewDelegate>

@property (nonatomic) NSDictionary *infoDic;
@property (nonatomic, retain)YMKMapView *map;

@end
