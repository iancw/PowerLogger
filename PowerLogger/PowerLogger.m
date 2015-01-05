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
#import "PLRecord.h"

@implementation PowerLogger

NSString *_path;
NSStringEncoding _encoding;

- (id)initWithPath: (NSString *)path
{
    _path = [path stringByExpandingTildeInPath];
    _encoding = NSUTF8StringEncoding;
    
    BOOL directoryFlag;
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:_path isDirectory:&directoryFlag];
    if (fileExists && directoryFlag){
        NSLog([NSString stringWithFormat: @"Detected that %@ is a directory", path]);
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [NSDateFormatter new];
        [formatter setDateFormat: @"yyyy_MM_dd_HHmm_ss"];
        [formatter setTimeZone: [NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        _path = [_path stringByAppendingPathComponent: [NSString stringWithFormat: @"wifi_log_%@.csv", [formatter stringFromDate: date]]];
    }
    [[NSFileManager defaultManager] createFileAtPath: _path contents :[[PLRecord csvHeader] dataUsingEncoding: _encoding] attributes:nil];

    NSLog([NSString stringWithFormat: @"Writing data to %@", _path]);
    return self;
}

- (void) appendCSV: (NSString*) csv
{
    NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath: _path];
    if (handle){
        [handle seekToEndOfFile];
        [handle writeData:[csv dataUsingEncoding:_encoding]];
        [handle closeFile];
    }else{
        NSLog([NSString stringWithFormat:@"No such file %@, something went wrong", _path]);
    }
}

- (void) scanNetworks
{
    CWWiFiClient *client = [CWWiFiClient sharedWiFiClient];
    CWInterface *interface = [client interface];
    NSError *err;
    NSSet *networks = [interface scanForNetworksWithName:nil error:&err];
    for (CWNetwork *network in networks)
    {
        [self printNetwork: network];
    }
}

- (void) printNetwork: (CWNetwork*) network
{
    PLRecord *rec = [[PLRecord alloc] initFromNetwork:network andDate: [NSDate date]];
    NSLog([rec asCSV]);
    [self appendCSV: [rec asCSV]];
}
@end
