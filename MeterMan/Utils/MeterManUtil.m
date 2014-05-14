//
//  MeterManUtil.m
//  MeterMan
//
//  Created by Zsolt Kiss on 2014.05.14..
//  Copyright (c) 2014 Zsolt Kiss. All rights reserved.
//

#import "MeterManUtil.h"

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


@end
