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

+ (PLRecord*) initFromNetwork:(CWNetwork *)network
{
    PLRecord *rec = [PLRecord new];
    [rec setRssi: [network rssiValue]];
    [rec setNoise: [network noiseMeasurement]];
    [rec setSsid: [network ssid]];
    CWChannel *chan = [network wlanChannel];
    [rec setBand: [chan channelBand]];
    [rec setWidth: [chan channelWidth]];
    [rec setChannelNo: [chan channelNumber]];
    return rec;
}

+ (NSString*) csvHeader
{
    return @"SSID,Band,Channel,ChannelWidth,RSSI(dBm),Noise(dBm)\n";
}

- (NSString*) asCSV
{
    return [NSString stringWithFormat: @"%@,%@,%d,%@,%d,%d\n",
     [self ssid],
     [PLRecord formatBand: [self band]],
     (int)[self channelNo],
     [PLRecord formatWidth: [self width]],
     (int)[self rssi],
     (int)[self noise]];
}
@end