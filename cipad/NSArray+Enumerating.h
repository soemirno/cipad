//
//  NSArray+Enumerating.h
//  cipad
//
//  Created by Soemirno Kartosoewito on 10-03-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Enumerating)

- (NSArray *) collect:(id (^)(id ob))block;

- (void) do:(void (^)(id obj))block;

@end
