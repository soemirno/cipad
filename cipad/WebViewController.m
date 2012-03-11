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

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        return YES;
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

- (void) splitViewController:(UISplitViewController *)svc 
      willHideViewController:(UIViewController *)aViewController 
           withBarButtonItem:(UIBarButtonItem *)barButtonItem 
        forPopoverController:(UIPopoverController *)pc{

    [barButtonItem setTitle:@"Jobs"];
    [[self navigationItem]setLeftBarButtonItem:barButtonItem];
}

- (void) splitViewController:(UISplitViewController *)svc 
      willShowViewController:(UIViewController *)aViewController 
   invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem{

    if (barButtonItem == [[self navigationItem] leftBarButtonItem])
        [[self navigationItem]setLeftBarButtonItem:nil];
    
    
}
@end
