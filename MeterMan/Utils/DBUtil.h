//
//  DBUtil.h
//  MeterMan
//
//  Created by Zsolt Kiss on 2014.05.16..
//  Copyright (c) 2014 Zsolt Kiss. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Meter;
@class ScanData;
@class ScanEventDueDate;
@class ScanEventType;
@class UtilityType;
@class MeterDetails;

extern NSString * const COMMON_NAME_FOR_SUPPLY_TYPE_WATER;
extern NSString * const COMMON_NAME_FOR_SUPPLY_TYPE_GAS;
extern NSString * const COMMON_NAME_FOR_SUPPLY_TYPE_ELECTRICITY;

@interface DBUtil : NSObject

+ (Meter *)meterAsBlankEntity;
+ (ScanData *)scanDataAsBlankEntity;
+ (ScanEventType *)scanEventTypeAsBlankEntity;
+ (ScanEventDueDate *)scanEventDueDateAsBlankEntity;
+ (UtilityType *)utilityTypeAsBlankEntity;

+ (BOOL)hasUtilities;
+ (void)prepareDatabase;
+ (void)commit;

+ (NSString *)utilityCommonNameByType:(PublicUtilityType)publicUtilityType;
+ (UtilityType *)utilityTypeForCommonName:(NSString *)name;

+ (NSArray *)metersByPublicUtilityType:(PublicUtilityType)publicUtilityType;

@end
