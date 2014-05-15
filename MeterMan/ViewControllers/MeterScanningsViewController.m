//
//  MeterScanningsViewController.m
//  MeterMan
//
//  Created by Zsolt Kiss on 2014.05.14..
//  Copyright (c) 2014 Zsolt Kiss. All rights reserved.
//

#import "MeterScanningsViewController.h"
#import "MeterManUtil.h"

@interface MeterScanningsViewController () {
    PDTSimpleCalendarViewController *_calendarVC;
}

@end

@implementation MeterScanningsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.lbInstallationAddress.text = nil;
    self.lbMeterId.text = nil;
    
    if (self.meterDetails) {
        UIImage *typeImage = [self.meterDetails typeImage];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:typeImage];
        
        CGFloat x = (CGRectGetWidth(self.holderView.frame) - CGRectGetWidth(imgView.frame)) / 2;
        CGFloat y = (CGRectGetHeight(self.holderView.frame) - CGRectGetHeight(imgView.frame)) / 2;
        
        CGRect frame = imgView.frame;
        frame.origin.x = x;
        frame.origin.y = y;
        
        imgView.frame = frame;
        
        [self.holderView addSubview:imgView];
//        imgView.center = self.holderView.center;
        
        self.lbAlias.text = _meterDetails.alias;
        self.lbInstallationAddress.text = self.meterDetails.installationAddress;
        self.lbMeterId.text = self.meterDetails.meterId;
        
    }
    
//    PDTSimpleCalendarViewController *calendarViewController = [[PDTSimpleCalendarViewController alloc] init];
//    //This is the default behavior, will display a full year starting the first of the current month
//    [calendarViewController setDelegate:self];
//    
//    _calendarVC = calendarViewController;
//    
//    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
//    CGFloat h = [[UIScreen mainScreen] bounds].size.height - CGRectGetMaxY(self.lbInstallationAddress.frame) - 10.0f;
//    
//    CGRect frame;
//    frame.origin.x = 0;
//    frame.origin.y = CGRectGetMaxY(self.lbMeterId.frame) + 10.0f;
//    frame.size.width = w;
//    frame.size.height = h;
//    
//    _calendarVC.view.frame = frame;
//    [self.view addSubview:_calendarVC.view];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PDTSimpleCalendarViewDelegate protocol
- (void)simpleCalendarViewController:(PDTSimpleCalendarViewController *)controller didSelectDate:(NSDate *)date {
    NSLog(@"selected date: %@", date);
}



- (IBAction)addReminder:(id)sender {
    
    NSString *template = NSLocalizedString(@"Meter check is due", @"Reminder title");
    
    NSString *reminderTitle = [NSString stringWithFormat:@"%@: %@", template, self.meterDetails.alias];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [NSDate date];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:2];
    [components setMinute:30];
    
    
//    [components setYear:2014];
//    [components setMonth:4];
//    [components setDay:15];
//    [components setHour:19];
//    [components setMinute:55];
//    [components setSecond:0];

    
    NSDate *someDateInTheFuture = [calendar dateByAddingComponents:components toDate:date options:0];
    
    NSLog(@"4 weeks later date: %@", someDateInTheFuture);
    
    [MeterManUtil createReminderWithTitle:reminderTitle forDate:someDateInTheFuture];
    
}
@end
