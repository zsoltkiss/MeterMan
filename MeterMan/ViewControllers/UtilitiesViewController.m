//
//  UtilitiesViewController.m
//  MeterMan
//
//  Created by Zsolt Kiss on 2014.05.14..
//  Copyright (c) 2014 Zsolt Kiss. All rights reserved.
//

#import "UtilitiesViewController.h"
#import "MeterListViewController.h"

@interface UtilitiesViewController ()

@end

@implementation UtilitiesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    MeterListViewController *nextVC = (MeterListViewController *)segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"pushFromWater"]) {
        nextVC.type = UtilityTypeWater;
    } else if ([segue.identifier isEqualToString:@"pushFromGas"]) {
        nextVC.type = UtilityTypeGas;
    } else if ([segue.identifier isEqualToString:@"pushFromElectricity"]) {
        nextVC.type = UtilityTypeElectricity;
    }
}


@end
