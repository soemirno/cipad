//
//  ListViewController.h
//  cipad
//
//  Created by Soemirno Kartosoewito on 10-03-12.
//

#import <Foundation/Foundation.h>
@class WebViewController;
@interface ListViewController : UITableViewController{

    NSMutableData *jsonData;
    NSArray *viewList;
    NSMutableDictionary *jobsMap;

}
@property (nonatomic, strong) NSString * urlString;
@property (nonatomic, strong) WebViewController * webViewController;

- (id) initWithURLString:(NSString *) urlString;
- (void) fetchEntries;

@end
