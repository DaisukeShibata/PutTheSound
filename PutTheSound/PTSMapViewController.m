//
//  PTSMapViewController.m
//  PutTheSound
//
//  Created by Daisuke Shibata on 2014/04/26.
//  Copyright (c) 2014年 Toshiki Chiba. All rights reserved.
//

#import "PTSMapViewController.h"
#import "MyAnnotation.h"

CGFloat const pinImageWidth = 15.0;
CGFloat const pinImageHeight = 15.0;
@interface PTSMapViewController ()
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@end

@implementation PTSMapViewController

#pragma mark - Lifecycle method
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.map = [[YMKMapView alloc] initWithFrame:self.view.frame appid:@"dj0zaiZpPXpvblhpUEVZNTlTSyZzPWNvbnN1bWVyc2VjcmV0Jng9NzA-"];
    
    //地図のタイプを指定 標準の地図を指定
    self.map.mapType = YMKMapTypeStandard;;
    
    [self.view addSubview:self.map];
    [self.view bringSubviewToFront:self.backButton];
    
    //YMKMapViewDelegateを登録
    self.map.delegate = self;
    
    //地図の位置と縮尺を設定
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [_infoDic[@"latitude"] doubleValue];
    coordinate.longitude = [_infoDic[@"longitude"] doubleValue];

    self.map.region = YMKCoordinateRegionMake(coordinate, YMKCoordinateSpanMake(0.002, 0.002));
    
    //ピンをつくる
    MyAnnotation* myAnnotation = [[MyAnnotation alloc] initWithLocationCoordinate:coordinate
                                                                            title:_infoDic[@"title"]
                                                                         subtitle:_infoDic[@"artist"]];
    //ピンをマップに追加
    [self.map addAnnotation:myAnnotation];
}

#pragma mark - YMKMapViewDelegate
- (YMKAnnotationView*)mapView:(YMKMapView *)mapView viewForAnnotation:(MyAnnotation*)annotation
{
    if( [annotation isKindOfClass:[MyAnnotation class]] ){
        //YMKPinAnnotationViewを作成
        YMKPinAnnotationView *pin = [[YMKPinAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"Pin"];
        if ([_infoDic[@"type"] isEqualToString:@"put"]) {
            pin.userInteractionEnabled = NO;
        }
        //アイコンイメージの変更
        pin.image=[UIImage imageNamed:@"pin_red_s.png"];
        CGPoint centerOffset = CGPointMake(pinImageWidth, pinImageHeight);
        [pin setCenterOffset:centerOffset];
        
        return pin;
    }
    return nil;
}

#pragma mark - Tap action
- (IBAction)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
