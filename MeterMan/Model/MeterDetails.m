//
//  MeterDetails.m
//  MeterMan
//
//  Created by Zsolt Kiss on 2014.05.14..
//  Copyright (c) 2014 Zsolt Kiss. All rights reserved.
//

#import "MeterDetails.h"
#import "MeterManUtil.h"



@interface MeterDetails () {
    NSMutableDictionary *_properties;
}



@end

@implementation MeterDetails

@synthesize moreProperties = _properties;

#pragma Class methods

//+ (UIImage *)imageForType:(PublicUtilityType)type {
//    UIFont *font = [UIFont fontWithName:FONT_FAMILY_FOR_TYPE_IMAGE size:FONT_SIZE_FOR_TYPE_IMAGE];
//    NSString *nameOfTheUtility = nil;
//    
//    switch (type) {
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
//    
//}

#pragma mark - Initialization
- (instancetype)init {
    return nil;
}

- (instancetype)initWithType:(PublicUtilityType)type {
    self = [super init];
    
    if (self) {
        self.type = type;
    }
    
    return self;
}

#pragma mark - Custom getter
//- (UIImage *)typeImage {
//    return [MeterDetails imageForType:self.type];
//}

#pragma mark - Public methods
- (void)addPropertyWithKey:(NSString *)key andValue:(NSString *)value {
    if (_properties == nil) {
        _properties = [[NSMutableDictionary alloc] initWithCapacity:3];
    }
    
    [_properties setObject:value forKey:key];
    
}

@end
