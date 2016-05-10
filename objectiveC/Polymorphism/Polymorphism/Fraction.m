#import "Fraction.h"

@implementation Fraction
@synthesize numerator, denominator;
-(void) print {
    NSLog (@" %i / %i ", numerator, denominator);
}

-(void) setNumerator: (int) a over: (int) b {
    numerator = a;
    denominator = b;
}

-(Fraction *) add: (Fraction *) f {
    Fraction *result = [[Fraction alloc] init];
    result.numerator = numerator * f.denominator + denominator * f.numerator;
    result.denominator = denominator * f.denominator;
    return result;
}

-(instancetype) initWith : (int) a over : (int) b
{
    self = [super init];
    
    if (self) {
        [self setNumerator: a over: b];
    }
    return self;
}
@end