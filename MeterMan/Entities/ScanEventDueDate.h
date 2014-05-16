//
//  ScanEventDueDate.h
//  MeterMan
//
//  Created by Zsolt Kiss on 2014.05.16..
//  Copyright (c) 2014 Zsolt Kiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Meter, ScanEventType;

@interface ScanEventDueDate : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) ScanEventType *scanEventType;
@property (nonatomic, retain) Meter *meter;

@end
