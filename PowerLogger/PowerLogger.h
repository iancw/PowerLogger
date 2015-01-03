//
//  PowerLogger.h
//  PowerLogger
//
//  Created by Ian Will on 1/3/15.
//  Copyright (c) 2015 Ian Will. All rights reserved.
//

#ifndef PowerLogger_PowerLogger_h
#define PowerLogger_PowerLogger_h

#import <CoreWLAN/CoreWLAN.h>
@interface PowerLogger:NSObject

- (id)initWithPath:(NSString*)path;
- (void)scanNetworks;
- (void)printNetwork: (CWNetwork*) network;

@end

#endif
