//
//  MeterManUtil.h
//  MeterMan
//
//  Created by Zsolt Kiss on 2014.05.14..
//  Copyright (c) 2014 Zsolt Kiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MeterDetails.h"
#import <EventKit/EventKit.h>

@interface MeterManUtil : NSObject

+ (UIImage *)imageWithText:(NSString *)text usingFont:(UIFont *)font andSize:(CGSize)size;
+ (UIColor *)bgColorForUtilityType:(PublicUtilityType)type;

+ (EKCalendar *)meterManCalendar;

+ (void)createReminderWithTitle:(NSString *)reminderTitle forDate:(NSDate *)reminderDate;


+ (UIImage *)imageForPublicUtilityType:(PublicUtilityType)publicUtilityType;

+ (void)informUserWithMessage:(NSString *)message title:(NSString *)title;



@end
