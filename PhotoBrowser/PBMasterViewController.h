//
//  PBMasterViewController.h
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/3/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "PBDataProvider.h"
#import "PBCustomCell.h"

@interface PBMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, PBDataProviderConsumerProtocol>{
    PBDataProvider *provider;
    NSMutableArray *imageGrid;
}

@property (nonatomic, strong) PBDataProvider *provider;
@property (nonatomic, strong) NSMutableArray *imageGrid;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

/**
 * Refresh list of flickr items
 */

- (void)reloadData;

@end
