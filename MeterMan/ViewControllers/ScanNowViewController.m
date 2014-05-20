//
//  ScanNowViewController.m
//  MeterMan
//
//  Created by Zsolt Kiss on 2014.05.19..
//  Copyright (c) 2014 Zsolt Kiss. All rights reserved.
//

#import "ScanNowViewController.h"
#import "DBUtil.h"
#import "ScanData.h"

@interface ScanNowViewController ()

@end

@implementation ScanNowViewController

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
    
    self.lbSupplierPhone.text = self.selectedMeter.supplierPhone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)documentWithPhoto:(id)sender {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    } else {
    
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
    
}

- (IBAction)scoreUp:(id)sender {
    
    if (self.tfCurrentValue.text.length > 0) {
        ScanData *newData = [DBUtil scanDataAsBlankEntity];
        newData.valueRead = @([self.tfCurrentValue.text doubleValue]);
        newData.date = [NSDate date];
        newData.meter = self.selectedMeter;
        newData.scanEventType = [DBUtil scanEventTypeForReadPeriod:MeterReadPeriodMonthlyScan];
        
        if (self.imageView.image != nil) {
            NSArray *previousDataWithPhoto = [DBUtil scanDataWithPhotoForMeter:self.selectedMeter];
            
            for (ScanData *oldData in previousDataWithPhoto) {
                oldData.photoTaken = @(0);
            }
            
            newData.photoTaken = @(1);
        }
        
        [DBUtil commit];
        
    }
    
    
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (IBAction)supplierPhoneLabelTapped:(UITapGestureRecognizer *)sender {
    
    NSString *phoneCallNum = [NSString stringWithFormat:@"tel://%@",self.selectedMeter.supplierPhone];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneCallNum]];
    
    NSLog(@"phone btn touch %@", phoneCallNum);
    
}
@end
