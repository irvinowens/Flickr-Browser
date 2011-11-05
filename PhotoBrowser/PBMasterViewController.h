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

@interface PBMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>{
    PBDataProvider *provider;
}

@property (nonatomic, strong) PBDataProvider *provider;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
