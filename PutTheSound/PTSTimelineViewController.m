//
//  PTSTimelineViewController.m
//  PutTheSound
//
//  Created by Daisuke Shibata on 2014/03/16.
//  Copyright (c) 2014年 Toshiki Chiba. All rights reserved.
//

#import "PTSTimelineViewController.h"
#import "PTSSlideViewController.h"
#import "PTSMapViewController.h"

static CGFloat const RefreshTimelineSec = 60.0f;
@interface PTSTimelineViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *timeLineItem;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSDictionary *selectedDic;
@end

@implementation PTSTimelineViewController


#pragma mark - Life cycle method
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(timerStart)
                                                 name:@"startTimer"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stopTimer)
                                                 name:@"stopTimer"
                                               object:nil];
    // scrollToTopの制御通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(p_setScrollsToTopNo)
                                                 name:openLeftNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(p_setScrollsToTopYes)
                                                 name:openRightNotification
                                               object:nil];
    
    [[PTSTimelineManager sharedManager] setDelegate:self];
    [self reloadAsync];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Notification
- (void)timerStart
{
    if ([_timer isValid]) {
        return;
    }
    [self reloadAsync];
    self.timer = [NSTimer timerWithTimeInterval:RefreshTimelineSec
                   target:self
                   selector:@selector(reloadAsync)
                   userInfo:nil
                   repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer
{
    if ([_timer isValid]) {
        [self.timer invalidate];
    }
}

- (void)p_setScrollsToTopNo
{
    [self.tableView setScrollsToTop:NO];
}
- (void)p_setScrollsToTopYes
{
    [self.tableView setScrollsToTop:YES];
}

#pragma mark - Private
- (void)reloadAsync
{
    NSLog(@"request");
    [[PTSTimelineManager sharedManager] request];
}

- (CGFloat)cellHeight:(NSAttributedString*)attrStr
{
    CGRect rect = [[attrStr string] boundingRectWithSize:CGSizeMake(175, 1000)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}
                                                 context:nil];
    CGFloat cellHeight = rect.size.height + 60;
    
    return cellHeight;
}

#pragma mark - UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_timeLineItem[indexPath.row][@"type"] isEqualToString:@"DateCell"]) {
        return 20.0f;
    }
    return [self cellHeight:_timeLineItem[indexPath.row][@"text"]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _timeLineItem.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_timeLineItem[indexPath.row][@"type"] isEqualToString:@"get"]) {
        static NSString *CellIdentifier = @"GetCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
        backView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f];
        cell.selectedBackgroundView = backView;
        
        UILabel *stationLabel = (UILabel*)[cell viewWithTag:1];
        stationLabel.attributedText = _timeLineItem[indexPath.row][@"text"];
        
        CGRect rect = [[stationLabel.attributedText string] boundingRectWithSize:CGSizeMake(175, 1000)
                                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                                      attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}
                                                                         context:nil];
        
        UIView *view = (UIView*) [cell viewWithTag:2];
        CGRect viewRect = view.frame;
        viewRect.size.width = rect.size.width + 30;
        viewRect.origin.x = 225 - viewRect.size.width;
        view.frame = viewRect;
        
        return cell;
    } else if ([_timeLineItem[indexPath.row][@"type"] isEqualToString:@"put"]) {
        
        static NSString *CellIdentifier = @"PutCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
        
        backView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.3f];
        cell.selectedBackgroundView = backView;

        UILabel *stationLabel = (UILabel*)[cell viewWithTag:1];
        stationLabel.attributedText = _timeLineItem[indexPath.row][@"text"];
        
        CGRect rect = [[stationLabel.attributedText string] boundingRectWithSize:CGSizeMake(175, 1000)
                                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                                      attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}
                                                                         context:nil];
        UIView *view = (UIView*) [cell viewWithTag:2];
        CGRect viewRect = view.frame;
        viewRect.size.width = rect.size.width + 30;
        view.frame = viewRect;
        
        return cell;
    } else {
        static NSString *CellIdentifier = @"DateCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        UILabel *dateLabel = (UILabel*)[cell viewWithTag:1];
        dateLabel.text = _timeLineItem[indexPath.row][@"date"];
        
        [[dateLabel layer] setCornerRadius:10.0];
        [dateLabel setClipsToBounds:YES];
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedDic = _timeLineItem[indexPath.row];
    if (_selectedDic[@"latitude"] != nil && _selectedDic[@"longitude"] != nil) {
        [self performSegueWithIdentifier:@"ToMapViewController" sender:self];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ToMapViewController"]) {
        PTSMapViewController *vc = segue.destinationViewController;
        vc.infoDic = _selectedDic;
    }
}

#pragma mark - PTSTimelineAPIDelegate
-(void)didFinishLoardWithObject:(NSArray *)array
{
    if (array !=nil) {
        self.timeLineItem = array;
        dispatch_async(dispatch_get_main_queue(), ^(){
            [_tableView reloadData];
        });
    }
}

@end
