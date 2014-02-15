//
//  PTSRecommendArtworkView.m
//  PutTheSound
//
//  Created by 山口 恭兵 on 2014/02/15.
//  Copyright (c) 2014年 Toshiki Chiba. All rights reserved.
//

#import "PTSRecommendArtworkView.h"

@implementation PTSRecommendArtworkView

- (void)_init
{
    // initialize
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self _init];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self _init];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.shadowOpacity = 1.0; // 濃さを指定
    self.layer.shadowRadius = 10.0f;
    self.layer.shadowOffset = CGSizeMake(0.0, 0.0); // 影までの距離を指定
}

/**
 *  PTSRecommendArtworkView.xibからInstanceを生成して返す
 *
 *  @return Instance
 */
+ (id)instanceFromNib
{
    UINib *nib = [UINib nibWithNibName:@"PTSRecommendArtworkView" bundle:nil];
    PTSRecommendArtworkView *view = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
    return view;
}

@end
