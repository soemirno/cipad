//
//  ListViewController.m
//  cipad
//
//  Created by Soemirno Kartosoewito on 10-03-12.
//

#import "ListViewController.h"
#import "CiConnection.h"

@implementation ListViewController

#pragma mark Initialization methods
- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        [self fetchEntries];
    }
    return self;
}

#pragma mark implementation ListViewController
- (void) fetchEntries{
    
    
    jsonData = [[NSMutableData alloc] init];
    
    NSURL *url = [NSURL URLWithString:@"https://ci.lille.inria.fr/pharo/api/json"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    CiConnection *connection = [[CiConnection alloc]initWithRequest:request];
    
    [connection setCompletionBlock:^(id container, NSError *error){
        if (container){
            NSDictionary *d = [NSJSONSerialization JSONObjectWithData:container options:0 error:nil] ;              
            views = [d objectForKey:@"views"];
            NSLog(@"json  = %@", views);
            [[self tableView] reloadData];
            
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Error" 
                                        message:[NSString stringWithFormat:@"Fetch failed: %@", [error localizedDescription]]
                                       delegate:nil 
                              cancelButtonTitle:@"OK" 
                              otherButtonTitles: nil]show];            
        }
        
    } ];
    [connection start];
    
}

#pragma mark UITableViewController delegates

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [views count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIndentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [[self tableView] dequeueReusableCellWithIdentifier:reuseIndentifier];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];


    NSDictionary *item =[views objectAtIndex:[indexPath row]] ;
    [[cell textLabel]setText:[item objectForKey:@"name"]];
                
    return cell;
}

@end
