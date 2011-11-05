//
//  PBImage.h
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/4/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

#import "PBModel.h"

/**
 * The PBImage model is the domain entity that encapsulates
 * a flickr photo, it also provides caching for the image
 * objects that will back the UI
 */

@interface PBImage : PBModel{
    NSString *imageTitle;
    NSString *imageId;
    NSString *webLink;
    NSDate *publishedDate;
    NSDate *updatedDate;
    NSDate *takenDate;
    NSString *content;
    UIImage *authorImage;
    UIImage *photoImage;
}

@property (nonatomic, strong) NSString *imageTitle;
@property (nonatomic, strong) NSString *imageId;
@property (nonatomic, strong) NSString *webLink;
@property (nonatomic, strong) NSDate *publishedDate;
@property (nonatomic, strong) NSDate *updatedDate;
@property (nonatomic, strong) NSDate *dateTaken;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) UIImage *authorImage;
@property (nonatomic, strong) UIImage *photoImage;

/**
 * Load the author image into memory
 */

- (void)loadAuthorImage;

/**
 * Unload the author image from memory
 */

- (void)unloadAuthorImage;

/**
 * Load the photo image into memory
 */

- (void)loadPhotoImage;

/**
 * Unload the photo image from memory
 */

- (void)unloadPhotoImage;

@end
