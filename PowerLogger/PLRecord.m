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
    [self setSsid: [network ssid]];
    CWChannel *chan = [network wlanChannel];
    [self setBand: [chan channelBand]];
    [self setWidth: [chan channelWidth]];
    [self setChannelNo: [chan channelNumber]];
    [self setDate: date];
    _formatter = [NSDateFormatter new];
    [_formatter setDateFormat: @"yyyy-MM-dd'T'HH:mm:ssZZZ"];
    [_formatter setTimeZone: [NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    return self;
}

+ (NSString*) csvHeader
{
    return @"Date,SSID,Band,Channel,ChannelWidth,RSSI(dBm),Noise(dBm)\n";
}

- (NSString*) asCSV
{
    return [NSString stringWithFormat: @"%@,%@,%@,%d,%@,%d,%d\n",
     [_formatter stringFromDate: [self date]],
     [self ssid],
     [PLRecord formatBand: [self band]],
     (int)[self channelNo],
     [PLRecord formatWidth: [self width]],
     (int)[self rssi],
     (int)[self noise]];
}
@end