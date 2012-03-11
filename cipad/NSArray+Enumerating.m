//
//  NSArray+Enumerating.m
//  cipad
//
//  Created by Soemirno Kartosoewito on 10-03-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSArray+Enumerating.h"

@implementation NSArray (Enumerating)

- (NSArray *) collect:(id (^)(id ob))block{

    NSMutableArray *newCollection = [[NSMutableArray alloc]init];
    [self do:^(id each){
        [newCollection addObject:block(each)];
    }];
    return [newCollection copy];
        
}

- (void) do:(void (^)(id obj))block{
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj);
    }];

}
@end
