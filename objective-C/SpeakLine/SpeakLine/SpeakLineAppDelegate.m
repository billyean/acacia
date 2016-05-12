//
//  SpeakLineAppDelegate.m
//  SpeakLine
//
//  Created by Yan, Tristan on 12/22/15.
//  Copyright © 2015 Yan, Tristan. All rights reserved.
//

#import "SpeakLineAppDelegate.h"

@implementation SpeakLineAppDelegate
@synthesize window = _window;
@synthesize textField = _textField;
- (id)init {
    self = [super init];
    if (self) {
        // Logs can help the beginner understand what
        // is happening and hunt down bugs.
        NSLog(@"init");
        _voices = [NSSpeechSynthesizer availableVoices];
        // Create a new instance of NSSpeechSynthesizer
        // with the default voice.
        // When the table view appears on screen, the default voice
        // should be selected
        NSString *defaultVoice = [NSSpeechSynthesizer defaultVoice];
        NSInteger defaultRow = [_voices indexOfObject:defaultVoice];
        NSIndexSet *indices = [NSIndexSet indexSetWithIndex:defaultRow];
        [_tableView selectRowIndexes:indices byExtendingSelection:NO];
        [_tableView scrollRowToVisible:defaultRow];
        _speechSynth = [[NSSpeechSynthesizer alloc] initWithVoice:defaultVoice];
        [_speechSynth setDelegate: self];

    }

    return self;
}
                        
- (IBAction)speakIt:(id)sender
{
    NSString *string = [_textField stringValue];
    // Is the string zero-length?
    if ([string length] == 0) {
        NSLog(@"string from %@ is of zero-length", _textField);
        return;
    }
    [_speechSynth startSpeakingString:string];
    [_stopButton setEnabled:YES];
    [_speakButton setEnabled:NO];
    [_tableView setEnabled:NO];
    NSLog(@"Have started to say: %@", string);
}

- (IBAction)stopIt:(id)sender
{
    NSLog(@"stopping");
    [_speechSynth stopSpeaking];
    
    [_stopButton setEnabled:NO];
    [_speakButton setEnabled:YES];
    [_tableView setEnabled:YES];
}

-(void)speechSynthesizer:(NSSpeechSynthesizer *)sender didFinishSpeaking:(BOOL)finishedSpeaking
{
    NSLog(@"finishedSpeaking = %d", finishedSpeaking);
    
    [_stopButton setEnabled:NO];
    [_speakButton setEnabled:YES];
    [_tableView setEnabled:YES];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tv
{
    return (NSInteger)[_voices count];
}

- (id)tableView:(NSTableView *)tv
objectValueForTableColumn:(NSTableColumn *)tableColumn
            row:(NSInteger)row
{
    NSString *v = [_voices objectAtIndex:row];
    return v;
}

- (void)tableViewSelectionDidChange: (NSNotification *) notification
{
    NSInteger row = [_tableView selectedRow];
    if (row == -1) {
        return;
    }
    NSString *selectedVoice = [_voices objectAtIndex:row];
    NSLog(@"selectedVoice = %@", selectedVoice);
    [_speechSynth setVoice:selectedVoice];
    NSLog(@"new voice = %@", selectedVoice);
}
@end
