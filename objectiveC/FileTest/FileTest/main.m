//
//  main.m
//  FileTest
//
//  Created by Yan, Tristan on 12/15/15.
//  Copyright © 2015 Yan, Tristan. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSFileManager *fm;
        NSString *testFileName = @"testfile";
        NSDictionary *attr;

        fm = [NSFileManager defaultManager];
        
        if ([fm fileExistsAtPath: @"newfile"] == YES) {
            if ([fm removeItemAtPath: @"newfile" error: NULL] == NO) {
                NSLog(@"Can't clean up existed newfile");
            }
            return 1;
        }
        
        if ([fm fileExistsAtPath: @"newfile2"] == YES) {
            if ([fm removeItemAtPath: @"newfile2" error: NULL] == NO) {
                NSLog(@"Can't clean up existed newfile2");
            }
            return 2;
        }
        
        if ([fm fileExistsAtPath: testFileName] == NO) {
            NSLog(@"File %@ doesn't exist", testFileName);
            return 3;
        }
        
        if ([fm copyItemAtPath: testFileName toPath: @"newfile" error: NULL] == NO) {
            NSLog(@"copy %@ to newfile failed", testFileName);
            return 4;
        }
        
        if ([fm contentsEqualAtPath: testFileName andPath: @"newfile"] == NO) {
            NSLog(@"New copied newfile is not identical to %@", testFileName);
            return 5;
        }
        
        if ([fm moveItemAtPath: @"newfile" toPath: @"newfile2" error: NULL] == NO) {
            NSLog(@"Move file newfile to newfile2 failed");
            return 6;
        }
        
        if ([fm contentsEqualAtPath: testFileName andPath: @"newfile2"] == NO) {
            NSLog(@"New moved newfile2 is not identical to %@", testFileName);
            return 7;
        }
        
        
        if ((attr = [fm attributesOfItemAtPath: @"newfile2" error: NULL]) == nil) {
            NSLog(@"Not able to acquire newfile2's attributes");
            return 8;
        }
        
        NSData *fileContent;
        
        fileContent = [fm contentsAtPath: @"newfile2"];
        if (fileContent == nil) {
            NSLog(@"No content in newfile2");
            return 9;
        }
        
        NSLog(@"File size of newfile2 is %llu", [[attr objectForKey: NSFileSize] unsignedLongLongValue]);
        
        NSString *cwd;
        if ((cwd = [fm currentDirectoryPath]) == nil) {
            NSLog(@"Can't get current directory");
            return 10;
        }
        NSLog(@"Current working directory is %@", cwd);
        
        NSDirectoryEnumerator *dirEnum;
        
        if ((dirEnum = [fm enumeratorAtPath: cwd]) == nil){
            NSLog(@"Can't get current directory's file list");
            return 11;
        }
        
        NSString *path;
        while ((path = [dirEnum nextObject]) != nil) {
            NSLog(@"%@", path);
        }
        
        NSArray *filesArray;
        
        filesArray = [fm contentsOfDirectoryAtPath: cwd error:NULL];
        for (path in filesArray) {
            NSLog(@"list file %@", path);
        }
    }
    return 0;
}
