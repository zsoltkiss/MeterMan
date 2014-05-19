//
//  ScanNowViewController.h
//  MeterMan
//
//  Created by Zsolt Kiss on 2014.05.19..
//  Copyright (c) 2014 Zsolt Kiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meter.h"

@interface ScanNowViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (nonatomic, weak) Meter *selectedMeter;

@property (weak, nonatomic) IBOutlet UILabel *lbSupplierPhone;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)shotAPicture:(id)sender;

- (IBAction)supplierPhoneLabelTapped:(UITapGestureRecognizer *)sender;


@end
