//
//  Fraction.h
//  Polymorphism
//
//  Created by Yan, Tristan on 12/11/15.
//  Copyright © 2015 Yan, Tristan. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef Fraction_h
#define Fraction_h


#endif /* Fraction_h */

@interface Fraction : NSObject
@property int numerator, denominator;
-(instancetype) initWith : (int) a over : (int) b;
-(void) print;
-(void) setNumerator : (int) a over : (int) b;
-(Fraction *) add : (Fraction *) f;
@end
