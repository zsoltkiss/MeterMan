//
//  MeterScanningsViewController.h
//  MeterMan
//
//  Created by Zsolt Kiss on 2014.05.14..
//  Copyright (c) 2014 Zsolt Kiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meter.h"
#import <PDTSimpleCalendar/PDTSimpleCalendar.h>

@interface MeterDetailsViewController : UIViewController <PDTSimpleCalendarViewDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lbAlias;
@property (weak, nonatomic) IBOutlet UILabel *lbMeterId;
@property (weak, nonatomic) IBOutlet UILabel *lbInstallationAddress;
@property (weak, nonatomic) IBOutlet UILabel *lbOwner;
@property (weak, nonatomic) IBOutlet UILabel *lbSupplierPhone;

@property(nonatomic, strong) Meter *selectedMeter;

- (IBAction)composeReminders:(UIBarButtonItem *)sender;
- (IBAction)showHistory:(UIBarButtonItem *)sender;

- (IBAction)persistMeterData:(UIBarButtonItem *)sender;

- (IBAction)editMeterDetails:(UIBarButtonItem *)sender;


- (IBAction)supplierPhoneLabelTapped:(UITapGestureRecognizer *)sender;

@end
