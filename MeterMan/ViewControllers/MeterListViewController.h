//
//  MeterListViewController.h
//  MeterMan
//
//  Created by Zsolt Kiss on 2014.05.14..
//  Copyright (c) 2014 Zsolt Kiss. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeterDetails.h"

@interface MeterListViewController : UITableViewController

@property(nonatomic, assign) UtilityType type;      ///< Utility type of meters shown on the table view

@end
