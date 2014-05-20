//
//  DBUtil.m
//  MeterMan
//
//  Created by Zsolt Kiss on 2014.05.16..
//  Copyright (c) 2014 Zsolt Kiss. All rights reserved.
//

#import "DBUtil.h"
#import "AppDelegate.h"
#import "Meter.h"
#import "ScanEventType.h"
#import "ScanEventDueDate.h"
#import "UtilityType.h"
#import "MeterDetails.h"

NSString * const COMMON_NAME_FOR_SUPPLY_TYPE_WATER = @"WATER";
NSString * const COMMON_NAME_FOR_SUPPLY_TYPE_GAS = @"GAS";
NSString * const COMMON_NAME_FOR_SUPPLY_TYPE_ELECTRICITY = @"ELECTRICITY";

NSString * const COMMON_NAME_FOR_YEARLY_SCAN = @"YEARLY_READ";
NSString * const COMMON_NAME_FOR_MONTHLY_SCAN = @"MONTHLY_READ";

@implementation DBUtil


+ (Meter *)meterAsBlankEntity {
    NSManagedObject *mo = [NSEntityDescription insertNewObjectForEntityForName:@"Meter" inManagedObjectContext:[DBUtil managedObjectContext]];
    
    return (Meter *)mo;
}

+ (ScanData *)scanDataAsBlankEntity {
    NSManagedObject *mo = [NSEntityDescription insertNewObjectForEntityForName:@"ScanData" inManagedObjectContext:[DBUtil managedObjectContext]];
    
    return (ScanData *)mo;
}

+ (ScanEventType *)scanEventTypeAsBlankEntity {
    NSManagedObject *mo = [NSEntityDescription insertNewObjectForEntityForName:@"ScanEventType" inManagedObjectContext:[DBUtil managedObjectContext]];
    
    return (ScanEventType *)mo;
}

+ (ScanEventDueDate *)scanEventDueDateAsBlankEntity {
    NSManagedObject *mo = [NSEntityDescription insertNewObjectForEntityForName:@"ScanEventDueDate" inManagedObjectContext:[DBUtil managedObjectContext]];
    
    return (ScanEventDueDate *)mo;
}

+ (UtilityType *)utilityTypeAsBlankEntity {
    NSManagedObject *mo = [NSEntityDescription insertNewObjectForEntityForName:@"UtilityType" inManagedObjectContext:[DBUtil managedObjectContext]];
    
    return (UtilityType *)mo;
}

+ (BOOL)hasUtilities {
    NSManagedObjectContext *ctx = [DBUtil managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UtilityType" inManagedObjectContext:ctx];
    [request setEntity:entity];
    [request setFetchLimit:1];
    NSError *error = nil;
    NSArray *results = [ctx executeFetchRequest:request error:&error];
    
    return (results != nil && results.count > 0);
}


+ (void)prepareDatabase {
    
    if ([DBUtil hasUtilities] == NO) {
        // Very likely that it is the first run of the app...
        
        UtilityType *waterSupply = [DBUtil utilityTypeAsBlankEntity];
        UtilityType *gasSupply = [DBUtil utilityTypeAsBlankEntity];
        UtilityType *electricitySupply = [DBUtil utilityTypeAsBlankEntity];
        
        waterSupply.typeId = @(PublicUtilityTypeWater);
        waterSupply.name = COMMON_NAME_FOR_SUPPLY_TYPE_WATER;
        
        gasSupply.typeId = @(PublicUtilityTypeGas);
        gasSupply.name = COMMON_NAME_FOR_SUPPLY_TYPE_GAS;
        
        electricitySupply.typeId = @(PublicUtilityTypeElectricity);
        electricitySupply.name = COMMON_NAME_FOR_SUPPLY_TYPE_ELECTRICITY;
        
        ScanEventType *eventTypeMonthlyScan = [DBUtil scanEventTypeAsBlankEntity];
        eventTypeMonthlyScan.typeId = @(MeterReadPeriodMonthlyScan);
        eventTypeMonthlyScan.name = COMMON_NAME_FOR_MONTHLY_SCAN;
        
        ScanEventType *eventTypeYearlyScan = [DBUtil scanEventTypeAsBlankEntity];
        eventTypeYearlyScan.typeId = @(MeterReadPeriodYearlyScan);
        eventTypeYearlyScan.name = COMMON_NAME_FOR_YEARLY_SCAN;

        [DBUtil commit];
        
    }
    
}

+ (UtilityType *)utilityTypeForCommonName:(NSString *)name {
   
    NSManagedObjectContext *ctx = [DBUtil managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
    [request setEntity:[NSEntityDescription entityForName:@"UtilityType" inManagedObjectContext:ctx]];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [ctx executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"Error when fetching data: %@", error.localizedDescription);
    }
    
    if (results && results.count > 0) {
        return [results objectAtIndex:0];
    }
    
    return nil;

}

+ (NSArray *)metersByPublicUtilityType:(PublicUtilityType)publicUtilityType {
    
    NSString *commonName = [DBUtil utilityCommonNameByType:publicUtilityType];
    UtilityType *utilityType = [DBUtil utilityTypeForCommonName:commonName];
    
    NSManagedObjectContext *ctx = [DBUtil managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"utilityType == %@", utilityType];
    [request setEntity:[NSEntityDescription entityForName:@"Meter" inManagedObjectContext:ctx]];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [ctx executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"Error when fetching Meter entities: %@", error.localizedDescription);
    }
    
    return results;

    
}

+ (NSArray *)allMeters {
    
    NSManagedObjectContext *ctx = [DBUtil managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Meter" inManagedObjectContext:ctx]];
    
    NSError *error = nil;
    NSArray *results = [ctx executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"Error when fetching Meter entities: %@", error.localizedDescription);
    }
    
    return results;
    
}

+ (NSArray *)scanDataForMeter:(Meter *)meter {
    
    NSManagedObjectContext *ctx = [DBUtil managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"meter == %@", meter];
    [request setEntity:[NSEntityDescription entityForName:@"ScanData" inManagedObjectContext:ctx]];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [ctx executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"Error when fetching ScanData entities: %@", error.localizedDescription);
    }
    
    return results;
}

+ (NSArray *)scanDataWithPhotoForMeter:(Meter *)meter {
    NSManagedObjectContext *ctx = [DBUtil managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"meter == %@ and photoTaken > 0", meter];
    [request setEntity:[NSEntityDescription entityForName:@"ScanData" inManagedObjectContext:ctx]];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [ctx executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"Error when fetching ScanData entities: %@", error.localizedDescription);
    }

    return results;
}


+ (NSString *)utilityCommonNameByType:(PublicUtilityType)publicUtilityType {
    
    NSString *utilityCommonName = nil;
    
    switch (publicUtilityType) {
        case PublicUtilityTypeWater:
            utilityCommonName = COMMON_NAME_FOR_SUPPLY_TYPE_WATER;
            break;
            
        case PublicUtilityTypeGas:
            utilityCommonName = COMMON_NAME_FOR_SUPPLY_TYPE_GAS;
            break;
            
        case PublicUtilityTypeElectricity:
            utilityCommonName = COMMON_NAME_FOR_SUPPLY_TYPE_ELECTRICITY;
            break;
            
        default:
            break;
    }
    
    return utilityCommonName;
    
}

+ (ScanEventType *)scanEventTypeForReadPeriod:(MeterReadPeriod)period {
    NSNumber *numTypeId = nil;
    switch (period) {
        case MeterReadPeriodMonthlyScan:
            numTypeId = @(MeterReadPeriodMonthlyScan);
            break;
            
        case MeterReadPeriodYearlyScan:
            numTypeId = @(MeterReadPeriodYearlyScan);
            break;
            
        default:
            break;
    }
    
    
    NSManagedObjectContext *ctx = [DBUtil managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"typeId == %@", numTypeId];
    [request setEntity:[NSEntityDescription entityForName:@"ScanEventType" inManagedObjectContext:ctx]];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [ctx executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"Error when fetching ScanEventType entities: %@", error.localizedDescription);
    }
    
    return (results.count > 0) ? results[0] : nil;
    
}


+ (void)commit {
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] saveContext];
}

+ (NSManagedObjectContext *)managedObjectContext {
    return [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
}

@end
