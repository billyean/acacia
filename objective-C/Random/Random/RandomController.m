//
//  RandomController.m
//  Random
//
//  Created by Yan, Tristan on 12/21/15.
//  Copyright © 2015 Yan, Tristan. All rights reserved.
//

#import "RandomController.h"

@implementation RandomController
- (IBAction)seed:(id)sender
{
    // Seed the random number generator with the time
    srandom((unsigned)time(NULL));
    [textField setStringValue:@"Generator seeded"];
}

- (IBAction)generate:(id)sender
{
    // Generate a number between 1 and 100 inclusive
    int generated;
    generated = (int)(random() % 100) + 1;
    NSLog(@"generated = %d", generated);
    // Ask the text field to change what it is displaying
    [textField setIntValue:generated];
}

- (void)awakeFromNib
{
    NSDate *now;
    now = [NSDate date];
    [textField setObjectValue:now];
}
@end
