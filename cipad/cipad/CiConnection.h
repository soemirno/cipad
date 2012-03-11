//
//  CiConnection.h
//  cipad
//
//  Created by Soemirno Kartosoewito on 10-03-12.
//

#import <Foundation/Foundation.h>

@interface CiConnection : NSObject<NSURLConnectionDataDelegate>{
    NSURLConnection *internalConnection;
    NSMutableData *container;
}

- (id) initWithRequest: (NSURLRequest *)req;

- (void) start;

@property (nonatomic, copy) NSURLRequest *request;
@property (nonatomic, copy) void (^completionBlock)(id obj, NSError *err);

@end
