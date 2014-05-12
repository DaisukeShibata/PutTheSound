//
//  MyAnnotation.h
//  PutTheSound
//
//  Created by Daisuke Shibata on 2014/04/26.
//  Copyright (c) 2014年 Toshiki Chiba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YMapKit/YMapKit.h>

@interface MyAnnotation : NSObject<YMKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;  //緯度経度
@property (nonatomic) NSString *annotationTitle;    //ピンのタイトル
@property (nonatomic) NSString *annotationSubtitle; //ピンのサブタイトル

- (id)initWithLocationCoordinate:(CLLocationCoordinate2D) coord
                           title:(NSString *)annTitle
                        subtitle:(NSString *)annSubtitle;
- (NSString *)title;
- (NSString *)subtitle;

@end
