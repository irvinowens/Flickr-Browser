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

@interface PBDataProvider : NSObject{
    __unsafe_unretained id <PBDataProviderConsumerProtocol> delegate;
    NSDateFormatter *fmat;
}

@property (nonatomic, strong) NSDateFormatter *fmat;

@property (nonatomic, assign) id <PBDataProviderConsumerProtocol> delegate;

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

@end

@protocol PBDataProviderConsumerProtocol <NSObject>

- (void)provider:(PBDataProvider *)provider receivedAndProcessedModelObjects:(NSMutableArray *)modelObjects;

@end