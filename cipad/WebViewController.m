//
//  WebViewController.m
//  cipad
//
//  Created by Soemirno Kartosoewito on 11-03-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController

-(void) loadView{
    CGRect screenFrame = [[UIScreen mainScreen] applicationFrame];
    UIWebView *wv = [[UIWebView alloc]initWithFrame:screenFrame];
    [wv setScalesPageToFit:YES];
    [self setView:wv];    
}

- (UIWebView *) webView{
    return (UIWebView *) [self view];
}
@end
