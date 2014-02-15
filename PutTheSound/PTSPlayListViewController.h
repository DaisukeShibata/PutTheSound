//
//  PTSPlayListViewController.h
//  PutTheSound
//
//  Created by 千葉 俊輝 on 2014/02/14.
//  Copyright (c) 2014年 Toshiki Chiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface PTSPlayListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) MPMusicPlayerController *player;
@property (nonatomic) NSDictionary *selectedSong;


@end
