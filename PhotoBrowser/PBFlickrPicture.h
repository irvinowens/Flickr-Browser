//
//  PBFlickrPicture.h
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/4/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

#import "PBModel.h"
#import "PBConsts.h"
#import "PBAuthor.h"
#import "PBImage.h"

/**
 * This object is a higher level object that encapsulates all information
 * about a given feed picture entity
 */

@interface PBFlickrPicture : PBModel{
    PBAuthor *author;
    PBImage *image;
}

@property (nonatomic, strong) PBAuthor *author;

@property (nonatomic, strong) PBImage *image;

@end
