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
        
        if (argc != 2){
            NSString* progName = [[NSString stringWithUTF8String: argv[0]] lastPathComponent];
            NSString* usage = [NSString stringWithFormat: @"Usage:  %@ <path to csv>\n", progName];
            printf([usage UTF8String]);
            return 1;
        }

        NSString* path = [NSString stringWithUTF8String: argv[1]];
        PowerLogger *pl = [[PowerLogger alloc] initWithPath: path];
        while(TRUE)
        {
            NSLog(@"Scanning...");
            [pl scanNetworks];
            sleep(5);
        }
    }
    return 0;
}
