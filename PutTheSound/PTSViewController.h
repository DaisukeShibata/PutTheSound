//
//  PTSViewController.h
//  PutTheSound
//
//  Created by 千葉 俊輝 on 2014/02/14.
//  Copyright (c) 2014年 Toshiki Chiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <iCarousel/iCarousel.h>
#import <QuartzCore/QuartzCore.h>

#import "PTSMusicStationAPIManager.h"
#import "SCOUtilImageView.h"
#import "PTSRecommendArtworkView.h"

@class PTSSlideViewController;

@interface PTSViewController : UIViewController
<iCarouselDelegate, iCarouselDataSource,PTSMusicStationAPIManagerDelegate,SCOUtilImageViewDelegate>

@property (nonatomic, weak) PTSSlideViewController *slideVC;

@end
