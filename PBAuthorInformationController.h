//
//  PBAuthorInformationController.h
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/6/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBConsts.h"
#import "PBFlickrPicture.h"
#import "PBRequestFactory.h"

/**
 * Provides details about the photo's author
 */

@interface PBAuthorInformationController : UITableViewController<PBRequestDataDelegate>{
    PBFlickrPicture *picture;
    PBRequestConnection *request;
}

@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) PBRequestConnection *request;

@property (strong, nonatomic) PBFlickrPicture *picture;

/**
 * Configure the cell
 * @property (UITableViewCell *)cell The table view clel
 * @property (NSIndexPath *)indexPath The index path
 */

- (void)configureCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;

@end
