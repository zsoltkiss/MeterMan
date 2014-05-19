//
//  MeterManUtil.m
//  MeterMan
//
//  Created by Zsolt Kiss on 2014.05.14..
//  Copyright (c) 2014 Zsolt Kiss. All rights reserved.
//

#import "MeterManUtil.h"

static NSString * const APP_CALENDAR_KEY = @"MeterManCalendar";

static CGSize const SIZE_FOR_TYPE_IMAGE = {40.0f, 40.0f};
static CGFloat const FONT_SIZE_FOR_TYPE_IMAGE = 28.0f;
static NSString * const FONT_FAMILY_FOR_TYPE_IMAGE = @"GillSans";       // Verdana-Bold, Copperplate-Bold, GillSans


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

//+ (UIColor *)bgColorForUtilityType:(PublicUtilityType)type {
//    switch (type) {
//        case PublicUtilityTypeWater:
//            return [UIColor colorWithRed:208/255.0f green:222/255.0f blue:245/255.0f alpha:1.0];
//            break;
//            
//        case PublicUtilityTypeGas:
//            return [UIColor colorWithRed:208/255.0f green:222/255.0f blue:86/255.0f alpha:1.0];
//            break;
//            
//        case PublicUtilityTypeElectricity:
//            return [UIColor colorWithRed:208/255.0f green:130/255.0f blue:86/255.0f alpha:1.0];
//            break;
//    }
//    
//    return nil;
//}

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


+ (UIImage *)imageForPublicUtilityType:(PublicUtilityType)publicUtilityType {
//    UIFont *font = [UIFont fontWithName:FONT_FAMILY_FOR_TYPE_IMAGE size:FONT_SIZE_FOR_TYPE_IMAGE];
//    NSString *nameOfTheUtility = nil;
//    
//    switch (publicUtilityType) {
//        case PublicUtilityTypeWater:
//            nameOfTheUtility = NSLocalizedString(@"Water", @"Supply name: water");
//            break;
//            
//        case PublicUtilityTypeGas:
//            nameOfTheUtility = NSLocalizedString(@"Gas", @"Supply name: gas");;
//            break;
//            
//        case PublicUtilityTypeElectricity:
//            nameOfTheUtility = NSLocalizedString(@"Electricity", @"Supply name: electricity");
//            break;
//            
//    }
//    
//    NSString *firstLetter = [nameOfTheUtility substringToIndex:1];
//    
//    return [MeterManUtil imageWithText:firstLetter usingFont:font andSize:SIZE_FOR_TYPE_IMAGE];
    
    
    switch (publicUtilityType) {
        case PublicUtilityTypeWater:
            return [UIImage imageNamed:@"utility_water"];
            break;
            
        case PublicUtilityTypeGas:
            return [UIImage imageNamed:@"utility_gas"];
            break;
            
        case PublicUtilityTypeElectricity:
            return [UIImage imageNamed:@"utility_electric"];
            break;
            
        default:
            break;
    }
    
    return nil;
    
}

+ (void)informUserWithMessage:(NSString *)message title:(NSString *)title {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
}

+ (void)setNavigationBarAppearence {
    //AvenirNextCondensed-Regular, Noteworthy-Bold, AvenirNextCondensed-Bold, AvenirNext-UltraLight
    
    UIFont *navTitleFont = [UIFont fontWithName:@"AvenirNext-Medium" size:22.0f];
    UIFont *leftBarButtonItemFont = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:16.0f];
    
    // Color for navigation items (back button, add button)
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    // Color for the background of the nav bar
    //81,48,31 barna
    //126,74,0 masik barna
    //199, 199, 204
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:74/255.0f green:74/255.0f blue:74/255.0f alpha:1.0f]];
    

//    UIColor *orangeGradientStartColor = [UIColor colorWithRed:1.0f green:149.0f/255 blue:0.0f alpha:1.0f];
//    UIColor *orangeGradientEndColor = [UIColor colorWithRed:1.0f green:94.0f/255 blue:58.0f alpha:1.0f];
//    
//    
//    UIImage *bgImage = [MeterManUtil imageWithGradientColors:orangeGradientStartColor color2:orangeGradientEndColor size:CGSizeMake(320.0f, 44.0f)];
//    
//    [[UINavigationBar appearance] setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    
    
    
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                                            NSFontAttributeName: navTitleFont,
                                                            NSForegroundColorAttributeName : [UIColor whiteColor]
                                                            }];
    
    UIBarButtonItem *barButtonItemProxy = [UIBarButtonItem appearanceWhenContainedIn:
                                           [UINavigationBar class], [UINavigationController class], nil];
    
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName : leftBarButtonItemFont,
                                     NSForegroundColorAttributeName : [UIColor whiteColor],
                                     };
    
    [barButtonItemProxy setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
}


+ (CALayer *)gradientBGLayerForBounds:(CGRect)bounds color1:(UIColor *)color1 color2:(UIColor *)color2 {
    CAGradientLayer * gradientBG = [CAGradientLayer layer];
    gradientBG.frame = bounds;
    gradientBG.colors = @[ (id)[color1 CGColor], (id)[color2 CGColor] ];
    return gradientBG;
}

+ (UIImage *)imageWithGradientColors:(UIColor *)color1 color2:(UIColor *)color2 size:(CGSize)expectedSize {
    
    CGRect rect = CGRectZero;
    rect.size.width = expectedSize.width;
    rect.size.height = expectedSize.height;
    
    CALayer * bgGradientLayer = [MeterManUtil gradientBGLayerForBounds:rect color1:color1 color2:color2];
    UIGraphicsBeginImageContext(bgGradientLayer.bounds.size);
    [bgGradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return gradientImage;
    
}

+ (UIColor *)backgroundColorForPublicUtilityType:(PublicUtilityType)publicUtilityType {
    switch (publicUtilityType) {
        case PublicUtilityTypeWater:
            return [UIColor colorWithRed:0.0f green:122.0f/255.0f blue:1.0f alpha:1.0f];
            break;
            
        case PublicUtilityTypeGas:
            return [UIColor colorWithRed:11.0f/255.0f green:211.0f/255.0f blue:24.0f/255.0f alpha:1.0f];
            break;
            
        case PublicUtilityTypeElectricity:
            return [UIColor colorWithRed:1.0f green:59.0f/255.0f blue:48.0f/255.0f alpha:1.0f];
            break;
            
        default:
            break;
    }
    
    return nil;
}




@end
