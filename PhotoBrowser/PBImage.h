//
//  PBImage.h
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/4/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

#import "PBConsts.h"
#import "PBModel.h"
#import "PBRequestFactory.h"

@protocol PBImageLoadingProtocol;

/**
 * The PBImage model is the domain entity that encapsulates
 * a flickr photo, it also provides caching for the image
 * objects that will back the UI
 */

@interface PBImage : PBModel <PBRequestDataDelegate>{
    NSString *imageTitle;
    NSString *imageId;
    NSString *webLink;
    NSDate *publishedDate;
    NSDate *updatedDate;
    NSDate *takenDate;
    NSString *content;
    UIImage *authorImage;
    UIImage *photoImage;
    UIImage *photoThumbnail;
    PBImageRequest *imageRequest;
    NSString *authorImageUri;
    NSString *photoImageUri;
    NSString *photoThumbnailUri;
    id delegate;
}

@property (strong, nonatomic) id delegate;

@property (nonatomic, strong) NSString *imageTitle;
@property (nonatomic, strong) NSString *imageId;
@property (nonatomic, strong) NSString *webLink;
@property (nonatomic, strong) NSDate *publishedDate;
@property (nonatomic, strong) NSDate *updatedDate;
@property (nonatomic, strong) NSDate *dateTaken;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) UIImage *authorImage;
@property (nonatomic, strong) UIImage *photoImage;
@property (nonatomic, strong) UIImage *photoThumbnail;
@property (nonatomic, strong) PBImageRequest *imageRequest;
@property (nonatomic, strong) NSString *authorImageUri;
@property (nonatomic, strong) NSString *photoImageUri;
@property (nonatomic, strong) NSString *photoThumbnailUri;

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

/**
 * Load the photo thumbnail image into the model
 */

- (void)loadPhotoThumbnailImage;

/**
 * Unload the photo thumbnail from the model
 */

- (void)unloadPhotoThumbnailImage;

@end

@protocol PBImageLoadingProtocol <NSObject>

/**
 * Inform the delegate that the image has successfully
 * been loaded
 */

- (void)imageLoadedSuccessfully:(PBImage *)image;

@end
