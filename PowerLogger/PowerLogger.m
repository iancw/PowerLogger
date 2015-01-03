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
        NSLog([NSString stringWithFormat:@"No such file %@, soemthing went wrong", _path]);
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
    PLRecord *rec = [PLRecord initFromNetwork:network];
    NSLog([rec asCSV]);
    [self appendCSV: [rec asCSV]];
}
@end
