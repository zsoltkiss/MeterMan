//
//  ScanData.h
//  MeterMan
//
//  Created by Zsolt Kiss on 2014.05.16..
//  Copyright (c) 2014 Zsolt Kiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Meter, ScanEventType;

@interface ScanData : NSManagedObject

@property (nonatomic, retain) NSNumber * valueRead;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) Meter *meter;
@property (nonatomic, retain) ScanEventType *scanEventType;

@end
