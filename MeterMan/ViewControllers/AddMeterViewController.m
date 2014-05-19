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
    
    [self localizeTexts];
    
    NSString *utilityTypeAsString;
    
    if (self.meterToEdit) {
//        _editModeActive = YES;
        self.publicUtilityType = [self.meterToEdit.utilityType.typeId integerValue];
        
//        self.lbTitle.text = NSLocalizedString(@"Editing your meter", @"Title of the view in edit mode");
        
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
    
    if (self.meterToEdit && self.meterToEdit && self.tfAlias.text.length > 0 && self.tfProductNo.text.length > 0) {
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
- (void)localizeTexts {
    
    if (self.meterToEdit) {
        self.lbTitle.text = NSLocalizedString(@"Edit your meter details", @"Title of the view in edit mode");
    } else {
        self.lbTitle.text = NSLocalizedString(@"Add new meter", @"Title of the view in add mode");
    }
    
    self.lbType.text = NSLocalizedString(@"Type", @"Label text");
    self.lbAlias.text = NSLocalizedString(@"Alias", @"Label text");
    self.lbAddress.text = NSLocalizedString(@"Address", @"Label text");
    self.lbProductNo.text = NSLocalizedString(@"Product No.", @"Label text");
    self.lbOwnerName.text = NSLocalizedString(@"Owner name", @"Label text");
    self.lbSupplierPhone.text = NSLocalizedString(@"Supplier phone", @"Label text");
    
    self.tfAlias.placeholder = NSLocalizedString(@"Arbitrary name for this meter", @"Placeholder text");
    self.tfAddress.placeholder = NSLocalizedString(@"Installation address (optional)", @"Placeholder text");
    self.tfProductNo.placeholder = NSLocalizedString(@"Product number (optional)", @"Placeholder text");
    self.tfOwner.placeholder = NSLocalizedString(@"Name of the owner (optional)", @"Placeholder text");
    self.tfSupplierPhone.placeholder = NSLocalizedString(@"Supplier company service phone (optional)", @"Placeholder text");
    
    [self.btnCancel setTitle:NSLocalizedString(@"Cancel", @"Button title") forState:UIControlStateNormal];
    [self.btnSave setTitle:NSLocalizedString(@"Save", @"Button title") forState:UIControlStateNormal];
}
@end
