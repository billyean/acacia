//
//  KvcFuncAppDelegate.m
//  KvcFun
//
//  Created by Yan, Tristan on 12/26/15.
//  Copyright © 2015 Yan, Tristan. All rights reserved.
//

#import "KvcFuncAppDelegate.h"

@implementation KvcFuncAppDelegate
- (id)init {
    self = [super init];
    if (self) {
        [self setValue:[NSNumber numberWithInt:5]
                forKey:@"fido"];
        NSNumber *n = [self valueForKey:@"fido"];
        NSLog(@"fido = %@", n);
    }
    return self;
}

- (int)fido {
    NSLog(@"-fido is returning %d", fido);
    return fido;
}

- (void)setFido:(int)x
{
    NSLog(@"-setFido: is called with %d", x);
    fido = x;
}

@end
