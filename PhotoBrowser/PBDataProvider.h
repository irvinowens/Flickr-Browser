//
//  PBDataProvider.h
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/4/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

#include "PBConsts.h"
#include "PBFeedRequest.h"
#include "PBRequestFactory.h"
#include "DDXML.h"
#include "PBAuthor.h"
#include "PBImage.h"
#include "PBFlickrPicture.h"

@protocol PBDataProviderConsumerProtocol;

/**
 * The purpose of the data provider is to
 * return high level collections of data
 * from a given data source
 */

@interface PBDataProvider : NSObject <PBRequestDataDelegate>{
    id <PBDataProviderConsumerProtocol> delegate;
    NSDateFormatter *fmat;
    PBRequestConnection *req;
}

@property (nonatomic, strong) NSDateFormatter *fmat;

/**
 * We want to hold onto the request for the lifecycle of the
 * processing
 */

@property (nonatomic, strong) PBRequestConnection *req;

@property (nonatomic, strong) id <PBDataProviderConsumerProtocol> delegate;

/**
 * Kickstart updating the data provider delegate with
 * new data from the feed
 */

- (void)updateDataWithPullFromFeed;

/**
 * Provided with an xml string, return an array of objects representing
 * the items in the feed
 * @param (DDXMLDocument *)feed The XML feed to parse into domain objects
 * @return The mutable array of objects
 */

- (NSMutableArray *)returnArrayOfModelObjectForGivenXmlFeedString:(DDXMLDocument *)feed;

/**
 * Given an author xml node populate an author object and return it
 * @param (DDXMLElement *)entryElement The entry xml node
 * @return The author model instance
 */

- (PBAuthor *)getAuthorModelForAuthorXmlNode:(DDXMLElement *)entryElement;

/**
 * Given the entry xml node, get an instance of the image model and return it
 * @param (DDXMLElement *)entryElement The entry xml element
 * @return The image model instance
 */

- (PBImage *)getImageModelForEntryXmlNode:(DDXMLElement *)entryElement;

/**
 * Assuming a thumbnail table view, break the array of entities into
 * subdivided array of subarrays
 * @param (NSMutableArray *)arr The array to cut up
 * @return A mutable array of arrays containing four image thumbnails
 */

- (NSMutableArray *)divideModelArrayIntoNestedArraysForThumbnailView:(NSMutableArray *)arr;

/**
 * Get Flickr thumbnail URI from feed larger image uri
 * @param (NSString *)largerImageUri The image URI for the larger image
 * @return The image string featuring the thumbnail uri
 */

- (NSString *)convertFlickrLargerImageUriToThumbnailImageUri:(NSString *)largerImageUri;

@end

@protocol PBDataProviderConsumerProtocol <NSObject>

- (void)provider:(PBDataProvider *)provider receivedAndProcessedModelObjects:(NSMutableArray *)modelObjects;

@end