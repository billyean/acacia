//
//  AppDelegate.m
//  SyncWindowSize
//
//  Created by Yan, Tristan on 12/23/15.
//  Copyright © 2015 Yan, Tristan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (NSSize)windowDidResize:(NSWindow *)sender
                   toSize:(NSSize)frameSize {
    return frameSize;
}
@end
