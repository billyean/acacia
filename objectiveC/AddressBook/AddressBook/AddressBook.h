//
//  AdrressBook.h
//  AddressBook
//
//  Created by Yan, Tristan on 12/15/15.
//  Copyright © 2015 Yan, Tristan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressCard.h"

#ifndef AdrressBook_h
#define AdrressBook_h


#endif /* AdrressBook_h */

@interface AddressBook: NSObject
@property (nonatomic, copy) NSString *bookName;
@property (nonatomic, strong) NSMutableArray *book;
-(instancetype) initWithName: (NSString *) name;
-(void) addCard: (AddressCard *) theCard;
-(NSUInteger) entries;
-(void) list;
-(AddressCard *) lookup: (NSString *) theName;
-(void) sort;
@end
