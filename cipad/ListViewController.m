//
//  ListViewController.m
//  cipad
//
//  Created by Soemirno Kartosoewito on 10-03-12.
//

#import "ListViewController.h"
#import "CiConnection.h"
#import "NSArray+Enumerating.h"
#import "WebViewController.h"

@implementation ListViewController

@synthesize urlString = _urlString;
@synthesize webViewController = _webViewController;

#pragma mark Initialization methods
- (id)initWithURLString:(NSString *)urlString {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.urlString = urlString;
        [[self navigationItem]setTitle:@"CI Jobs"];
        [self fetchEntries];
    }
    return self;
}

#pragma mark implementation ListViewController
- (void) fetchEntries{
    
    
    jsonData = [[NSMutableData alloc] init];
    
    NSURL *url = [NSURL URLWithString:[self urlString]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    CiConnection *connection = [[CiConnection alloc]initWithRequest:request];
    
    [connection setCompletionBlock:^(id container, NSError *error){
        if (container){
            NSDictionary *d = [NSJSONSerialization JSONObjectWithData:container options:0 error:nil] ;
            viewList = [d objectForKey:@"views"];
            jobsMap = [[NSMutableDictionary alloc] init ];
                                
            for (NSDictionary *subDict in viewList){
                [self fetchJobsFor:subDict];
            }

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
- (void) fetchJobsFor: (NSDictionary *) view{
    
    jsonData = [[NSMutableData alloc] init];
    
    NSURL *url = [NSURL URLWithString:[[view objectForKey:@"url"]stringByAppendingString:@"/api/json"]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    CiConnection *connection = [[CiConnection alloc]initWithRequest:request];
    
    [connection setCompletionBlock:^(id container, NSError *error){
        if (container){
            NSDictionary *d = [NSJSONSerialization JSONObjectWithData:container options:0 error:nil] ;
            NSLog(@"%@", d);
            NSArray *jobs = [d objectForKey:@"jobs"];
            
            [jobsMap setObject: jobs forKey:[view objectForKey:@"name"]];
            
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

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [viewList count];    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *view =[viewList objectAtIndex:section] ;
    return [view objectForKey:@"name"];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *view =[viewList objectAtIndex:section] ;
    return [[jobsMap objectForKey:[view objectForKey:@"name"]]count];
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIndentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [[self tableView] dequeueReusableCellWithIdentifier:reuseIndentifier];
    id cellClass = [UITableViewCell class];
    if (cell == nil)
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];

//    [[cell contentView] setBackgroundColor:[UIColor redColor]];
    NSDictionary *view =[viewList objectAtIndex:[indexPath section]] ;
    NSArray *jobs =[jobsMap objectForKey:[view objectForKey:@"name"]];
    NSDictionary *job = [jobs objectAtIndex:[indexPath row]];
    [[cell textLabel]setText:[job objectForKey:@"name" ]];
                
    return cell;
    

}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *view =[viewList objectAtIndex:[indexPath section]] ;
    NSArray *jobs =[jobsMap objectForKey:[view objectForKey:@"name"]];
    NSDictionary *job = [jobs objectAtIndex:[indexPath row]];
    NSLog(@"selected %@", [job objectForKey:@"url"]);
    
    [[self navigationController]pushViewController:[self webViewController] animated:YES];

    NSURL *url = [NSURL URLWithString:[job objectForKey:@"url"]];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [[[self webViewController] webView]loadRequest:request];
    [[[self webViewController] navigationItem] setTitle:[job objectForKey:@"name"]];
    
}

@end
