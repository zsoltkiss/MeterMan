//
//  MeterScanningsViewController.m
//  MeterMan
//
//  Created by Zsolt Kiss on 2014.05.14..
//  Copyright (c) 2014 Zsolt Kiss. All rights reserved.
//

#import "MeterScanningsViewController.h"
#import "MeterManUtil.h"
#import "UtilityType.h"
#import "AddMeterViewController.h"
#import "ScanNowViewController.h"

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
    
    self.title = NSLocalizedString(@"Details", @"View title");
    
    
    
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

- (void)viewWillAppear:(BOOL)animated {
    [self refreshControls];
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


- (void)refreshControls {
    if (self.selectedMeter) {
        UIImage *typeImage =    [MeterManUtil imageForPublicUtilityType:[self.selectedMeter.utilityType.typeId integerValue]];
        self.view.backgroundColor = [MeterManUtil backgroundColorForPublicUtilityType:[self.selectedMeter.utilityType.typeId integerValue]];
        self.imgView.image = typeImage;
        self.lbAlias.text = self.selectedMeter.alias;
        self.lbInstallationAddress.text = self.selectedMeter.installationAddress;
        self.lbMeterId.text = self.selectedMeter.productNumber;
        self.lbOwner.text = self.selectedMeter.ownerName;
        self.lbSupplierPhone.text = self.selectedMeter.supplierPhone;
    }
}


- (IBAction)addReminder:(id)sender {
    
    NSString *template = NSLocalizedString(@"Meter check is due", @"Reminder title");
    
    NSString *reminderTitle = [NSString stringWithFormat:@"%@: %@", template, self.selectedMeter.alias];
    
    
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

- (IBAction)composeReminders:(UIBarButtonItem *)sender {
}

- (IBAction)showHistory:(UIBarButtonItem *)sender {
}

- (IBAction)persistMeterData:(UIBarButtonItem *)sender {
    
}

- (IBAction)editMeterDetails:(UIBarButtonItem *)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddMeterViewController *editVC = [storyboard instantiateViewControllerWithIdentifier:@"addEditMeter"];
    
    editVC.meterToEdit = self.selectedMeter;
    
    [self presentViewController:editVC animated:YES completion:nil];
    
}


- (IBAction)supplierPhoneLabelTapped:(UITapGestureRecognizer *)sender {
    
    NSString *phoneCallNum = [NSString stringWithFormat:@"tel://%@",self.selectedMeter.supplierPhone];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneCallNum]];
    
    NSLog(@"phone btn touch %@", phoneCallNum);
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ScanNowViewController *scanNowVC = (ScanNowViewController *)segue.destinationViewController;
    scanNowVC.selectedMeter = self.selectedMeter;
}

@end
