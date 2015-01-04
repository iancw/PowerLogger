//
//  PLRecord.m
//  PowerLogger
//
//  Created by Ian Will on 1/3/15.
//  Copyright (c) 2015 Ian Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLRecord.h"

@implementation PLRecord

NSDateFormatter *_formatter;

+ (NSString*) formatBand: (CWChannelBand) band
{
    switch(band)
    {
        case kCWChannelBand2GHz:
            return @"2.4 GHz";
        case kCWChannelBand5GHz:
            return @"5 GHz";
        default:
            return @"Unknown";
    }
}

+ (NSString*) formatWidth: (CWChannelWidth) width
{
    switch(width)
    {
        case kCWChannelWidth20MHz:
            return @"20 MHz";
        case kCWChannelWidth40MHz:
            return @"40 MHz";
        case kCWChannelWidth80MHz:
            return @"80 MHz";
        case kCWChannelWidth160MHz:
            return @"160 MHz";
        default:
            return @"Unknown";
    }
}

- (id) initFromNetwork:(CWNetwork *)network andDate:(NSDate *)date
{
    [self setRssi: [network rssiValue]];
    [self setNoise: [network noiseMeasurement]];
    [rec setSsid: [network ssid]];
    CWChannel *chan = [network wlanChannel];
    [rec setBand: [chan channelBand]];
    [rec setWidth: [chan channelWidth]];
    [rec setChannelNo: [chan channelNumber]];
    [rec setDate: date];
    ec._formatter =
    return rec;
}

+ (NSString*) csvHeader
{
    return @"Date,SSID,Band,Channel,ChannelWidth,RSSI(dBm),Noise(dBm)\n";
}

- (NSString*) asCSV
{
    return [NSString stringWithFormat: @"%@,%@,%@,%d,%@,%d,%d\n",
     [self date],
     [self ssid],
     [PLRecord formatBand: [self band]],
     (int)[self channelNo],
     [PLRecord formatWidth: [self width]],
     (int)[self rssi],
     (int)[self noise]];
}
@end