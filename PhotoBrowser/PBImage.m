//
//  PBImage.m
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/4/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

#import "PBImage.h"

@implementation PBImage

@synthesize imageTitle, imageId, webLink, publishedDate, updatedDate, content, authorImage, photoImage, dateTaken, imageRequest, authorImageUri, photoImageUri, photoThumbnailUri, photoThumbnail, delegate;

- (void)loadAuthorImage
{
    
}

- (void)unloadAuthorImage
{
    
}

- (void)loadPhotoImage
{
    self.imageRequest = (PBImageRequest *)[PBRequestFactory makeRequestWith:kIMAGE_REQUEST_TYPE andDelegate:self];
    [self.imageRequest setImageRequestType:kFULL_PHOTO_IMAGE];
    [self.imageRequest makeRequestToUrl:[NSURL URLWithString:self.photoImageUri]];
}

- (void)unloadPhotoImage
{
    self.photoImage = nil;
}

- (void)loadPhotoThumbnailImage
{
    DebugLog(@"Photo Thumbnail : %@", self.photoThumbnailUri);
    self.imageRequest = (PBImageRequest *)[PBRequestFactory makeRequestWith:kIMAGE_REQUEST_TYPE andDelegate:self];
    [self.imageRequest setImageRequestType:kTHUMBNAIL_PHOTO_IMAGE];
    [self.imageRequest makeRequestToUrl:[NSURL URLWithString:self.photoThumbnailUri]];
}

- (void)unloadPhotoThumbnailImage
{
    self.photoThumbnail = nil;
}

#pragma mark-
#pragma mark Begin PBFeedRequestDelegate methods

- (void)requestCompleted:(PBRequestConnection *)request withData:(NSData *)data
{
    if([(PBImageRequest *)request imageRequestType] == kFULL_PHOTO_IMAGE)
    {
        self.photoImage = [UIImage imageWithData:data];
    }else if([(PBImageRequest *)request imageRequestType]){
        self.photoThumbnail = [UIImage imageWithData:data];
    }
    if([self.delegate respondsToSelector:@selector(imageLoadedSuccessfully:)])
    {
        [self.delegate performSelector:@selector(imageLoadedSuccessfully:) withObject:self];
    }
}

- (void)requestMade:(PBRequestConnection *)request
{
    
}

- (void)request:(PBRequestConnection *)request experiencedError:(NSError *)error
{
    
}

#pragma mark End PBFeedRequestDelegate methods
#pragma mark-

@end
