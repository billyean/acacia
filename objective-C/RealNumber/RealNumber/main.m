//
//  main.m
//  RealNumber
//
//  Created by Yan, Tristan on 12/9/15.
//  Copyright © 2015 Yan, Tristan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Complex : NSObject
-(void) setReal : (double)r;
-(void) setImage : (double)i;
-(void) print;
-(void) plus : (Complex*) c;
-(void) minus : (Complex*) c;
-(void) times : (Complex*) c;
@end

@implementation Complex
{
    double real;
    double image;
}
-(void) setReal : (double)r
{
    real = r;
}
-(void) setImage : (double)i
{
    image = i;
}
-(void) print
{
    NSLog(@"%f + %fi", real, image);
}
-(void) plus : (Complex*) c
{
    real += c->real;
    image += c->image;
}
-(void) minus : (Complex*) c
{
    real -= c->real;
    image -= c->image;
}
-(void) times : (Complex*) c
{
    double tr = real * c->real - image * c->image;
    double ti = real * c->image + image * c->real;
    real = tr;
    image = ti;
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Complex* c1 = [[Complex alloc] init];
        [c1 setReal:1.5];
        [c1 setImage: 10.4];
        [c1 print];
        
        
        Complex* c2 = [[Complex alloc] init];
        [c2 setReal: 8];
        [c2 setImage: 10];
        [c2 print];
        
        NSLog(@"c1 + c2 = ");
        [c1 plus: c2];
        [c1 print];
        
        NSLog(@"c1 * c2 = ");
        [c1 minus: c2];
        [c1 times: c2];
        [c1 print];
    }
    return 0;
}
