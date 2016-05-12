//
//  main.m
//  DictionaryDemo
//
//  Created by Yan, Tristan on 12/15/15.
//  Copyright © 2015 Yan, Tristan. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableDictionary *glossary = [[NSMutableDictionary alloc] init];
        [glossary setObject:@"A class defined so other classes can inherit from it" forKey: @"abstract class"];
        [glossary setObject:@"To implement all the methods defined in a protocol" forKey: @"adopt"];
        [glossary setObject:@"Storing an object for later use" forKey: @"archiving"];
        
        NSLog (@"abstract class: %@", glossary[@"abstract class"]);
        NSLog (@"adopt: %@", glossary[@"adopt"]);
        NSLog (@"archiving: %@", glossary[@"archiving"]);
    }
    return 0;
}
