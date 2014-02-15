//
//  PTSSlideViewController.h
//  PutTheSound
//
//  Created by 山口 恭兵 on 2014/02/15.
//  Copyright (c) 2014年 Toshiki Chiba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

/**
 *  Slideを管理するViewController
 */
@interface PTSSlideViewController : UIViewController

@property (assign, nonatomic, getter= isClosed) BOOL closed;

- (void)shouldOpenLeft;
- (void)shouldOpenRight;
- (void)shouldClose;

@end
