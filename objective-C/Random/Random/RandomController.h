//
//  RandomController.h
//  Random
//
//  Created by Yan, Tristan on 12/21/15.
//  Copyright © 2015 Yan, Tristan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>

@interface RandomController<NSNibAwaking> : NSObject
{
    IBOutlet NSTextField *textField;
}
- (IBAction)seed:(id)sender;
- (IBAction)generate:(id)sender;
@end
