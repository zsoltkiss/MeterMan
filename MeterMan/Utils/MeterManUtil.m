//
//  MeterManUtil.m
//  MeterMan
//
//  Created by Zsolt Kiss on 2014.05.14..
//  Copyright (c) 2014 Zsolt Kiss. All rights reserved.
//

#import "MeterManUtil.h"

static NSString * const APP_CALENDAR_KEY = @"MeterManCalendar";

@implementation MeterManUtil


+ (UIImage *)imageWithText:(NSString *)text usingFont:(UIFont *)font andSize:(CGSize)size {
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    
    // optional: add a shadow, to avoid clipping the shadow you should make the context size bigger
    //
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextSetShadowWithColor(ctx, CGSizeMake(1.0, 1.0), 5.0, [[UIColor grayColor] CGColor]);
    
    // draw in context, you can use also drawInRect:withFont:
    
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                font, NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName,
                                /*@1, NSUnderlineStyleAttributeName,*/
                                nil];
    
    [text drawAtPoint:CGPointZero withAttributes:attributes];
    
    
    // transfer image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;

}

+ (UIColor *)bgColorForUtilityType:(UtilityType)type {
    switch (type) {
        case UtilityTypeWater:
            return [UIColor colorWithRed:208/255.0f green:222/255.0f blue:245/255.0f alpha:1.0];
            break;
            
        case UtilityTypeGas:
            return [UIColor colorWithRed:208/255.0f green:222/255.0f blue:86/255.0f alpha:1.0];
            break;
            
        case UtilityTypeElectricity:
            return [UIColor colorWithRed:208/255.0f green:130/255.0f blue:86/255.0f alpha:1.0];
            break;
    }
    
    return nil;
}

+ (EKCalendar *)meterManCalendar {
    EKCalendar *calendar;
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    EKSource *localSource = nil;
    for (EKSource *someSource in eventStore.sources) {
        if (someSource.sourceType == EKSourceTypeLocal) {
            localSource = someSource;
        }
    }
    
    NSString *calendarId = [[NSUserDefaults standardUserDefaults] objectForKey:APP_CALENDAR_KEY];
   
    if (calendarId == nil || calendarId.length == 0) {
        // We have to create the calendar if it doesn't exist yet
        
        calendar = [EKCalendar calendarForEntityType:EKEntityTypeReminder eventStore:eventStore];
        calendar.title = NSLocalizedString(@"Timing meter reading", @"Title of the local calendar used by the app");
        calendar.source = localSource;
        NSError *creationError;
        if ([eventStore saveCalendar:calendar commit:YES error:&creationError] == NO) {
            NSLog(@"Calendar creation failed. %@", creationError.localizedDescription);
        } else {
            // Calendar successfully created
            [[NSUserDefaults standardUserDefaults] setObject:calendar.calendarIdentifier forKey:APP_CALENDAR_KEY];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"Calendar created with id: %@", calendar.calendarIdentifier);
        }
    } else {
        calendar = [eventStore calendarWithIdentifier:calendarId];
    }
    
    return calendar;
    
}

+ (void)createReminderWithTitle:(NSString *)reminderTitle forDate:(NSDate *)reminderDate {
    
    NSLog(@"%@ called with: %@, %@", NSStringFromSelector(_cmd), reminderTitle, reminderDate);
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    [eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error) {
        if (!granted) {
            NSLog(@"Access to Event Store not granted");
        } else {
            
            
            EKReminder *reminder = [EKReminder reminderWithEventStore:eventStore];
            
            reminder.title = reminderTitle;
            reminder.priority = 4;
            
            reminder.calendar = [eventStore defaultCalendarForNewReminders];
            
            EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:reminderDate];
            
            [reminder addAlarm:alarm];
            
            NSError *error = nil;
            BOOL success = [eventStore saveReminder:reminder commit:YES error:&error];
            
            if (!success) {
                NSLog(@"Error occured when creating reminder. %@", error.localizedDescription);
            }
            
            
        }
    }];
    
    
    
}


@end
