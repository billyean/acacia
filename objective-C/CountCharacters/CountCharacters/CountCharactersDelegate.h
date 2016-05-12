//
//  CountCharactersDelegate.h
//  CountCharacters
//
//  Created by Yan, Tristan on 12/22/15.
//  Copyright © 2015 Yan, Tristan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface CountCharactersDelegate : NSObject<NSApplicationDelegate>
@property IBOutlet NSTextField *textField;
@property IBOutlet NSTextField *countField;

- (IBAction) count: (id)sender;
@end
