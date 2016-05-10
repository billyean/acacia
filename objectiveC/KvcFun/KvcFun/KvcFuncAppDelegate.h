//
//  KvcFuncAppDelegate.h
//  KvcFun
//
//  Created by Yan, Tristan on 12/26/15.
//  Copyright © 2015 Yan, Tristan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface KvcFuncAppDelegate : NSObject <NSApplicationDelegate> {
    int fido;
}
@property (assign) IBOutlet NSWindow *window;

- (int)fido;
- (void)setFido:(int)x;

@end
