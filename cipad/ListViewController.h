//
//  ListViewController.h
//  cipad
//
//  Created by Soemirno Kartosoewito on 10-03-12.
//

#import <Foundation/Foundation.h>

@interface ListViewController : UITableViewController{

    NSMutableData *jsonData;
    NSArray *views;
}

- (void) fetchEntries;

@end
