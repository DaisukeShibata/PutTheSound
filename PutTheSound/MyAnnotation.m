//
//  MyAnnotation.m
//  PutTheSound
//
//  Created by Daisuke Shibata on 2014/04/26.
//  Copyright (c) 2014年 Toshiki Chiba. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

- (id)initWithLocationCoordinate:(CLLocationCoordinate2D) coord
                           title:(NSString *)annTitle subtitle:(NSString *)annSubtitle {
    if (self=[super init]) {
        _coordinate.latitude = coord.latitude;
        _coordinate.longitude = coord.longitude;
        _annotationTitle = annTitle;
        _annotationSubtitle = annSubtitle;
    }
    return self;
}

//ピンのタイトル
- (NSString *)title
{
    return _annotationTitle;
}

//ピンのサブタイトル
- (NSString *)subtitle
{
    return _annotationSubtitle;
}

@end
