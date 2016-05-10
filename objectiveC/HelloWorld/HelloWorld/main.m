//
//  main.m
//  HelloWorld
//
//  Created by Yan, Tristan on 12/9/15.
//  Copyright © 2015 Yan, Tristan. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        int sum;
        sum = 25  +50;
        NSLog(@"The sum of 25 and 50 is %i", sum);
        
        int i;
        i = 1;
        NSLog(@"Testing...");
        NSLog(@"....%i", i);
        NSLog(@"...%i", i + 1);
        NSLog(@"..%i", i + 2);
    }
    return 0;
}
