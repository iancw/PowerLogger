//
//  PowerLogger.m
//  PowerLogger
//
//  Created by Ian Will on 1/3/15.
//  Copyright (c) 2015 Ian Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreWLAN/CoreWLAN.h>
#import "PowerLogger.h"

@implementation PowerLogger

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

+ (void) scanNetworks
{
    CWWiFiClient *client = [CWWiFiClient sharedWiFiClient];
    CWInterface *interface = [client interface];
    NSError *err;
    NSSet *networks = [interface scanForNetworksWithName:nil error:&err];
    for (CWNetwork *network in networks)
    {
        [PowerLogger printNetwork: network];
    }
}

+ (void) printNetwork: (CWNetwork*) network
{
    NSInteger rssi = [network rssiValue];
    NSInteger noise = [network noiseMeasurement];
    NSString *ssid = [network ssid];
    CWChannel *chan = [network wlanChannel];
    CWChannelBand band = [chan channelBand];
    CWChannelWidth width = [chan channelWidth];
    NSInteger channelNo = [chan channelNumber];
    NSLog([NSString stringWithFormat:@"%@ rssi=%d dBm, noise=%d dBm, band=%@, channel=%d, channel width=%@",
           ssid, (int) rssi, (int) noise, [PowerLogger formatBand: band], (int)channelNo, [PowerLogger formatWidth: width]]);
    
}
@end
