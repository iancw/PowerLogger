//
//  main.m
//  PowerLogger
//
//  Created by Ian Will on 1/2/15.
//  Copyright (c) 2015 Ian Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PowerLogger.h"



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog([NSString stringWithFormat:@"Argc=%d", argc]);
        NSString* path = [NSString stringWithUTF8String: argv[0]];
        NSLog([NSString stringWithFormat:@"Argc=%d", argc]);
        PowerLogger *pl = [[PowerLogger alloc] initWithPath: path];
        {

            [pl scanNetworks];
            sleep(5);
        }
    }
    return 0;
}
