//
//  SpeakLineAppDelegate.h
//  SpeakLine
//
//  Created by Yan, Tristan on 12/22/15.
//  Copyright © 2015 Yan, Tristan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface SpeakLineAppDelegate : NSObject<NSApplicationDelegate, NSSpeechSynthesizerDelegate, NSTableViewDelegate>  {
    NSArray *_voices;
    NSSpeechSynthesizer *_speechSynth;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSTextField *textField;
@property (weak) IBOutlet NSButton *stopButton;
@property (weak) IBOutlet NSButton *speakButton;
-(IBAction) stopIt: (id) sender;
-(IBAction) speakIt: (id)Sender;
- (id)tableView:(NSTableView *)tv objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;
@end
