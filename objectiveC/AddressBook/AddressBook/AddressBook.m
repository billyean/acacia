//
//  AddressBook.m
//  AddressBook
//
//  Created by Yan, Tristan on 12/15/15.
//  Copyright © 2015 Yan, Tristan. All rights reserved.
//

#import "AddressBook.h"

@implementation AddressBook
@synthesize bookName, book;
// set up the AddressBook’s name and an empty book
-(instancetype) initWithName: (NSString *) name {
    self = [super init];
    if (self) {
        bookName = [NSString stringWithString: name];
        book = [NSMutableArray array];
    }
    return self;
}

-(instancetype) init {
    return [self initWithName: @"NoName"];
}

-(NSUInteger) entries {
    return [book count];
}

-(void) list {
    NSLog (@"======== Contents of: %@ =========", bookName);
    for (AddressCard *theCard in book )
        NSLog (@"%-20s %-32s", [theCard.name UTF8String],[theCard.email UTF8String]);
    NSLog (@"====================================================");
}

-(void) addCard: (AddressCard *)theCard {
    [book addObject: theCard];
}

-(AddressCard *) lookup: (NSString *) theName {
    for ( AddressCard *nextCard in book )
        if ( [nextCard.name caseInsensitiveCompare: theName] == NSOrderedSame )
            return nextCard;
    return nil;
}

-(void) sort {
    //[book sortUsingSelector: @selector(compareName:)];
    [book sortUsingComparator:
     ^(id id1, id id2) {
         return [[id1 email] compare: [id2 email]];
     } ];
}
@end