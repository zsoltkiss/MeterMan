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
#import "MeterManUtil.h"
#import "MeterListViewController.h"

@interface AddMeterViewController ()

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
    
    switch (self.utilityType) {
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
    
    if (self.tfAlias.text.length > 0 && self.tfProductNo.text.length > 0) {
        
        NSString *utilityCommonName = [DBUtil utilityCommonNameByType:self.utilityType];
        
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
