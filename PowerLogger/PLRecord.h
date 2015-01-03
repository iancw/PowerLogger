//
//  PLRecord.h
//  PowerLogger
//
//  Created by Ian Will on 1/3/15.
//  Copyright (c) 2015 Ian Will. All rights reserved.
//

#ifndef PowerLogger_PLRecord_h
#define PowerLogger_PLRecord_h

#import <CoreWLAN/CoreWLAN.h>

@interface PLRecord : NSObject


@property NSInteger rssi;
@property NSInteger noise;
@property NSString *ssid;
@property CWChannelBand band;
@property CWChannelWidth width;
@property NSInteger channelNo;

+ (PLRecord*)initFromNetwork:(CWNetwork*)network;
+ (NSString*) csvHeader;
- (NSString*)asCSV;

@end

#endif
