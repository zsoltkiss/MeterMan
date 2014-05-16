//
//  Meter.h
//  MeterMan
//
//  Created by Zsolt Kiss on 2014.05.16..
//  Copyright (c) 2014 Zsolt Kiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ScanData, ScanEventDueDate, UtilityType;

@interface Meter : NSManagedObject

@property (nonatomic, retain) NSString * alias;
@property (nonatomic, retain) NSString * supplierPhone;
@property (nonatomic, retain) NSString * productNumber;
@property (nonatomic, retain) NSString * installationAddress;
@property (nonatomic, retain) NSString * ownerName;
@property (nonatomic, retain) NSString * moreProperties;
@property (nonatomic, retain) UtilityType *utilityType;
@property (nonatomic, retain) NSSet *dueDateItems;
@property (nonatomic, retain) NSSet *scanDataItems;
@end

@interface Meter (CoreDataGeneratedAccessors)

- (void)addDueDateItemsObject:(ScanEventDueDate *)value;
- (void)removeDueDateItemsObject:(ScanEventDueDate *)value;
- (void)addDueDateItems:(NSSet *)values;
- (void)removeDueDateItems:(NSSet *)values;

- (void)addScanDataItemsObject:(ScanData *)value;
- (void)removeScanDataItemsObject:(ScanData *)value;
- (void)addScanDataItems:(NSSet *)values;
- (void)removeScanDataItems:(NSSet *)values;

@end
