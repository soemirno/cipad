//
//  CiConnection.m
//  cipad
//
//  Created by Soemirno Kartosoewito on 10-03-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CiConnection.h"

static NSMutableArray *sharedConnectionList = nil;

@implementation CiConnection

@synthesize request, completionBlock;

- (id) initWithRequest:(NSURLRequest *)req{
    self = [super init];

    if (!self) return self;
    
    [self setRequest:req];
    
    return self;
}

- (void) start{
    
    container = [[NSMutableData alloc] init];    
    
    internalConnection =[[NSURLConnection alloc]initWithRequest:[self request] 
                                                       delegate:self 
                                               startImmediately:YES];
    
    if (!sharedConnectionList)
        sharedConnectionList = [[NSMutableArray alloc]init];
    
    [sharedConnectionList addObject:self];
}

#pragma mark NSURLConnectionDataDelegate delegates

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [container appendData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection{
    if ([self completionBlock]) {
        [self completionBlock](container, nil);
    }
    
    [sharedConnectionList removeObject:self];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    if ([self completionBlock]) {
        [self completionBlock](nil, error);
    }
    
    [sharedConnectionList removeObject:self];
    
}
@end


