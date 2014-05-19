//
//  AddMeterViewController.h
//  MeterMan
//
//  Created by Zsolt Kiss on 2014.05.16..
//  Copyright (c) 2014 Zsolt Kiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meter.h"


@interface AddMeterViewController : UIViewController <UITextFieldDelegate>

@property(nonatomic, assign) PublicUtilityType publicUtilityType;

@property (nonatomic, weak) Meter *meterToEdit;

@property (weak, nonatomic) IBOutlet UILabel *lbType;
@property (weak, nonatomic) IBOutlet UILabel *lbUtilityType;
@property (weak, nonatomic) IBOutlet UILabel *lbAlias;
@property (weak, nonatomic) IBOutlet UILabel *lbAddress;
@property (weak, nonatomic) IBOutlet UILabel *lbProductNo;
@property (weak, nonatomic) IBOutlet UILabel *lbOwnerName;
@property (weak, nonatomic) IBOutlet UILabel *lbSupplierPhone;


@property (weak, nonatomic) IBOutlet UITextField *tfAlias;
@property (weak, nonatomic) IBOutlet UITextField *tfAddress;
@property (weak, nonatomic) IBOutlet UITextField *tfProductNo;
@property (weak, nonatomic) IBOutlet UITextField *tfOwner;
@property (weak, nonatomic) IBOutlet UITextField *tfSupplierPhone;
@property (weak, nonatomic) IBOutlet UIButton *addEditButton;

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;

@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

- (IBAction)addMeter:(id)sender;
- (IBAction)cancelAdding:(id)sender;

@end
