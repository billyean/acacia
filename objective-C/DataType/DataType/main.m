//
//  main.m
//  DataType
//
//  Created by Yan, Tristan on 12/10/15.
//  Copyright © 2015 Yan, Tristan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Test : NSObject
@property NSString* name;
-(Test *) initWithName : (NSString *) aname;
-(void) run;
@end

@implementation Test
@synthesize name;
-(Test *) initWithName : (NSString *) aname {
    self = [super init];
    self.name = aname;
    return self;
}

-(void) run{
    NSLog(@"%@", name);
}
@end



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        int integerVar = 100;
        float folatingVar = 331.79;
        double doubleVar = 8.44e+11;
        char charVar = 'T';
        unsigned int unsignedIntegerVar = 4294967295;
        long longVar = 4294967296;
        NSLog(@"integerVar = %i", integerVar);
        NSLog(@"folatingVar = %f", folatingVar);
        NSLog(@"doubleVar = %e", doubleVar);
        NSLog(@"doubleVar = %g", doubleVar);
        NSLog(@"charVar = %c", charVar);
        NSLog(@"unsignedIntegerVar = %u", unsignedIntegerVar);
        NSLog(@"longVar = %li", longVar);
        
        Test* t = [[Test alloc] initWithName: @"First"];
        //t.name = @"New Name";
        [t run];
    }
    return 0;
}
