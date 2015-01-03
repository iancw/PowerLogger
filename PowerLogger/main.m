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
        while(TRUE)
        {
            PowerLogger *pl = [[PowerLogger alloc] init];
            [pl scanNetworks];
            sleep(5);
        }
    }
    return 0;
}
