//
//  AddMeterViewController.m
//  MeterMan
//
//  Created by Zsolt Kiss on 2014.05.16..
//  Copyright (c) 2014 Zsolt Kiss. All rights reserved.
//

#import "AddMeterViewController.h"
#import "DBUtil.h"
#import "Meter.h"
#import "UtilityType.h"
#import "MeterManUtil.h"
#import "MeterListViewController.h"

@interface AddMeterViewController () {
    BOOL _editModeActive;
}

@end

@implementation AddMeterViewController

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
    
    NSString *utilityTypeAsString;
    
    if (self.meterToEdit) {
        _editModeActive = YES;
        self.publicUtilityType = [self.meterToEdit.utilityType.typeId integerValue];
        
        self.lbTitle.text = @"Editing your meter";
        
        self.tfAlias.text = self.meterToEdit.alias;
        self.tfAddress.text = self.meterToEdit.installationAddress;
        self.tfProductNo.text = self.meterToEdit.productNumber;
        self.tfOwner.text = self.meterToEdit.ownerName;
        self.tfSupplierPhone.text = self.meterToEdit.supplierPhone;
        
//        [self.addEditButton setTitle:@"Save changes" forState:UIControlStateNormal];
    }
    
    switch (self.publicUtilityType) {
        case PublicUtilityTypeWater:
            utilityTypeAsString = NSLocalizedString(@"Water", @"Type name on meter add view");
            break;
            
        case PublicUtilityTypeGas:
            utilityTypeAsString = NSLocalizedString(@"Gas", @"Type name on meter add view");
            break;
            
        case PublicUtilityTypeElectricity:
            utilityTypeAsString = NSLocalizedString(@"Electricity", @"Type name on meter add view");
            break;
            
        default:
            break;
    }
    
    self.lbUtilityType.text = utilityTypeAsString;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addMeter:(id)sender {
    
    if (_editModeActive && self.meterToEdit && self.tfAlias.text.length > 0 && self.tfProductNo.text.length > 0) {
        self.meterToEdit.alias = self.tfAlias.text;
        self.meterToEdit.installationAddress = self.tfAddress.text;
        self.meterToEdit.productNumber = self.tfProductNo.text;
        self.meterToEdit.ownerName = self.tfOwner.text;
        self.meterToEdit.supplierPhone = self.tfSupplierPhone.text;
        
        [DBUtil commit];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        if (self.tfAlias.text.length > 0 && self.tfProductNo.text.length > 0) {
            
            NSString *utilityCommonName = [DBUtil utilityCommonNameByType:self.publicUtilityType];
            
            UtilityType *utilityType = [DBUtil utilityTypeForCommonName:utilityCommonName];
            
            Meter *newMeter = [DBUtil meterAsBlankEntity];
            newMeter.utilityType = utilityType;
            newMeter.alias = self.tfAlias.text;
            newMeter.installationAddress = self.tfAddress.text;
            newMeter.productNumber = self.tfProductNo.text;
            newMeter.ownerName = self.tfOwner.text;
            newMeter.supplierPhone = self.tfSupplierPhone.text;
            
            [DBUtil commit];
            
            UINavigationController *nc = (UINavigationController *)self.presentingViewController;
            
            MeterListViewController *topVC = [nc.viewControllers lastObject];
            topVC.refreshNeeded = YES;
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            NSString *title = NSLocalizedString(@"Missing data", @"Alert view title");
            [MeterManUtil informUserWithMessage:nil title:title];
            
        }
    }
    
}

- (IBAction)cancelAdding:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Private methods
- (void)customizeTypeLabel {
    
}
@end
