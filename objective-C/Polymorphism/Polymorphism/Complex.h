//
//  Complex.h
//  Polymorphism
//
//  Created by Yan, Tristan on 12/11/15.
//  Copyright © 2015 Yan, Tristan. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef Complex_h
#define Complex_h


#endif /* Complex_h */

@interface Complex : NSObject
@property double real, imaginary;
-(void) print;
-(void) setReal : (double) a andImaginary : (double) b;
-(Complex *) add : (Complex *) f;
@end
