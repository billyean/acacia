//
//  AddressCard.m
//  AddressBook
//
//  Created by Yan, Tristan on 12/15/15.
//  Copyright © 2015 Yan, Tristan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressCard.h"

@implementation AddressCard
{
    NSString *name;
    NSString *email;
}
-(void) setName: (NSString *) theName {
    name = [NSString stringWithString: theName];
}

-(void) setEmail: (NSString *) theEmail {
    email = [NSString stringWithString: theEmail];
}

-(void) setName: (NSString *) theName andEmail: (NSString *) theEmail {
    name = [NSString stringWithString: theName];
    email = [NSString stringWithString: theEmail];
}

-(NSString *) name {
    return name;
}

-(NSString *) email {
    return email;
}

-(void) print {
    NSLog (@"====================================");
    NSLog (@"|                                  |");
    NSLog (@"| %-32s |", [name UTF8String]);
    NSLog (@"| %-32s |", [email UTF8String]);
    NSLog (@"|                                  |");
    
    NSLog (@"|                                  |");
    NSLog (@"|                                  |");
    NSLog (@"|     O                      O     |");
    NSLog (@"====================================");
}

-(NSComparisonResult) compareName: (id) element {
    return [name compare: [element name]];
}
@end