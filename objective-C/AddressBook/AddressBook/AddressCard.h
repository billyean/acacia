//
//  AddressCard.h
//  AddressBook
//
//  Created by Yan, Tristan on 12/15/15.
//  Copyright © 2015 Yan, Tristan. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef AddressCard_h
#define AddressCard_h


#endif /* AddressCard_h */

@interface AddressCard: NSObject
-(void) setName: (NSString *) theName;
-(void) setEmail: (NSString *) theEmail;
-(void) setName: (NSString *) theName andEmail : (NSString *) theEmail;
-(NSString *) name;
-(NSString *) email;
-(void) print;
-(NSComparisonResult) compareName: (id) element;
@end