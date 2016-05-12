//
//  Document.h
//  RaiseMain
//
//  Created by Yan, Tristan on 12/30/15.
//  Copyright © 2015 Yan, Tristan. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Document : NSDocument {
    NSMutableArray *employees;
}

- (void)setEmployees:(NSMutableArray *)a;

@end

