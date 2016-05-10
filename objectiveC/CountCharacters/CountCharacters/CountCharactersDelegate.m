//
//  CountCharactersDelegate.m
//  CountCharacters
//
//  Created by Yan, Tristan on 12/22/15.
//  Copyright © 2015 Yan, Tristan. All rights reserved.
//

#import "CountCharactersDelegate.h"


@implementation CountCharactersDelegate
@synthesize textField;
@synthesize countField;

- (IBAction) count: (id)sender {
    NSString *text = [textField stringValue];
    NSUInteger length = [text length];
    [countField setIntValue: (int)length];
}

@end
