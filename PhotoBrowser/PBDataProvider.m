//
//  PBDataProvider.m
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/4/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

#import "PBDataProvider.h"

@implementation PBDataProvider

@synthesize fmat, delegate, req;

- (id)init
{
    if(self = [super init])
    {
        self.fmat = [[NSDateFormatter alloc] init];
    }
    return self;
}

- (void)updateDataWithPullFromFeed
{
    self.req = nil;
    self.req = [PBRequestFactory makeRequestWith:kFEED_REQUEST_TYPE andDelegate:self];
    DebugLog(@"Requesting feed");
}

- (NSMutableArray *)returnArrayOfModelObjectForGivenXmlFeedString:(DDXMLDocument *)feed
{
    NSError *error = nil;
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:500];
    NSArray *entryNodes = [(DDXMLElement *)feed elementsForName:@"entry"];
    for(DDXMLElement *ele in entryNodes)
    {
        DebugLog(@"Feed Element: %@", [(DDXMLNode *)ele XMLString]);
        PBFlickrPicture *pic = [[PBFlickrPicture alloc] init];
        PBAuthor *author = [self getAuthorModelForAuthorXmlNode:ele];
        // might cause a problem if somehow there are more than 1 author
        NSArray *authorPicArray = [ele nodesForXPath:@"/link[rel='enclosure']" error:&error];
        for(DDXMLElement *authorPic in authorPicArray)
        {
            author.profilePhoto = [[authorPic attributeForName:@"href"] stringValue];
        }
        PBImage *image = [self getImageModelForEntryXmlNode:ele];
        pic.author = author;
        pic.image = image;
        [arr addObject:pic];
    }
    return arr;
}

- (PBImage *)getImageModelForEntryXmlNode:(DDXMLElement *)entryElement
{
    NSError *error = nil;
    PBImage *image = [[PBImage alloc] init];
    image.imageTitle = [[entryElement childAtIndex:0] stringValue];
    image.imageId = [[entryElement childAtIndex:2] stringValue];
    NSDate *published = [self.fmat dateFromString:[[entryElement childAtIndex:3] stringValue]];
    image.publishedDate = published;
    NSDate *updated = [self.fmat dateFromString:[[entryElement childAtIndex:4] stringValue]];
    image.updatedDate = updated;
    NSDate *taken = [self.fmat dateFromString:[[entryElement childAtIndex:5] stringValue]];
    image.dateTaken = taken;
    image.content = [[entryElement childAtIndex:6] stringValue];
     NSArray *webLinkArray = [entryElement nodesForXPath:@"/link[rel='alternate']" error:&error];
    for(DDXMLElement *webLink in webLinkArray)
    {
        image.webLink = [[webLink attributeForName:@"href"] stringValue];
    }
    return image;
}

- (PBAuthor *)getAuthorModelForAuthorXmlNode:(DDXMLElement *)entryElement
{
    PBAuthor *author = [[PBAuthor alloc] init];
    NSArray *authorArr = [entryElement elementsForName:@"author"];
    for(DDXMLElement *authorElement in authorArr)
    {
        author.name = [[authorElement childAtIndex:0] stringValue];
        author.profileUri = [[authorElement childAtIndex:1] stringValue];
        author.buddyIcon = [[authorElement childAtIndex:3] stringValue];
    }
    return author;
}

#pragma mark-
#pragma mark Begin PBFeedRequestDelegate methods

- (void)requestCompleted:(PBRequestConnection *)request withData:(NSData *)data
{
#ifdef DEBUG_MODE
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    DebugLog(@"Response %@", str);
#endif
    NSError *error = nil;
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:data 
                                                     options:DDXMLDocumentXMLKind 
                                                       error:&error];
    if(error != nil){
        
        DebugLog(@"XML Parsing Error : %@", [error localizedDescription]);
    }
    NSMutableArray *arr = [self returnArrayOfModelObjectForGivenXmlFeedString:doc];
    if([self.delegate respondsToSelector:@selector(provider:receivedAndProcessedModelObjects:)])
    {
        [self.delegate performSelector:@selector(provider:receivedAndProcessedModelObjects:) withObject:self withObject:arr];
    }
    
}

- (void)requestMade:(PBRequestConnection *)request
{
    DebugLog(@"Request made through delegate");
}

- (void)request:(PBRequestConnection *)request experiencedError:(NSError *)error
{
    DebugLog(@"Felt Error %@", error);
}

#pragma mark End PBFeedRequestDelegate methods
#pragma mark-

@end
