//
//  MeterDetails.h
//  MeterMan
//
//  Created by Zsolt Kiss on 2014.05.14..
//  Copyright (c) 2014 Zsolt Kiss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeterDetails : NSObject

@property(nonatomic, assign) PublicUtilityType type;
@property(nonatomic, strong) NSString *alias;
@property(nonatomic, strong) NSString *meterId;
@property(nonatomic, strong) NSString *ownerName;
@property(nonatomic, strong) NSString *installationAddress;
@property(nonatomic, readonly) NSDictionary *moreProperties;
@property(nonatomic, strong) UIImage *meterImage;
//@property(nonatomic, readonly) UIImage *typeImage;

//+ (UIImage *)imageForType:(PublicUtilityType)type;

- (instancetype)initWithType:(PublicUtilityType)type;
- (void)addPropertyWithKey:(NSString *)key andValue:(NSString *)value;


@end
