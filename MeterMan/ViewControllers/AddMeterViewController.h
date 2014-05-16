//
//  AddMeterViewController.h
//  MeterMan
//
//  Created by Zsolt Kiss on 2014.05.16..
//  Copyright (c) 2014 Zsolt Kiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeterDetails.h"


@interface AddMeterViewController : UIViewController <UITextFieldDelegate>

@property(nonatomic, assign) PublicUtilityType utilityType;

@property (weak, nonatomic) IBOutlet UILabel *lbUtilityType;
@property (weak, nonatomic) IBOutlet UITextField *tfAlias;
@property (weak, nonatomic) IBOutlet UITextField *tfAddress;
@property (weak, nonatomic) IBOutlet UITextField *tfProductNo;
@property (weak, nonatomic) IBOutlet UITextField *tfOwner;
@property (weak, nonatomic) IBOutlet UITextField *tfSupplierPhone;



- (IBAction)addMeter:(id)sender;
- (IBAction)cancelAdding:(id)sender;

@end
