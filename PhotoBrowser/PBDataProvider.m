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
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:500];
    NSArray *entryNodes = [[feed rootElement] elementsForName:@"entry"];
    for(DDXMLElement *ele in entryNodes)
    {
        PBFlickrPicture *pic = [[PBFlickrPicture alloc] init];
        PBAuthor *author = [self getAuthorModelForAuthorXmlNode:ele];
        PBImage *image = [self getImageModelForEntryXmlNode:ele];
        pic.author = author;
        pic.image = image;
        [arr addObject:pic];
    }
    return arr;
}

- (PBImage *)getImageModelForEntryXmlNode:(DDXMLElement *)entryElement
{
    PBImage *image = [[PBImage alloc] init];
    image.imageTitle = [[entryElement childAtIndex:0] stringValue];
    DebugLog(@"image title : %@", image.imageTitle);
    image.imageId = [[entryElement childAtIndex:2] stringValue];
    NSDate *published = [self.fmat dateFromString:[[entryElement childAtIndex:3] stringValue]];
    image.publishedDate = published;
    NSDate *updated = [self.fmat dateFromString:[[entryElement childAtIndex:4] stringValue]];
    image.updatedDate = updated;
    NSDate *taken = [self.fmat dateFromString:[[entryElement childAtIndex:5] stringValue]];
    image.dateTaken = taken;
    image.content = [[entryElement childAtIndex:6] stringValue];
    NSArray *webLinkArray = [entryElement elementsForName:@"link"];
    for(DDXMLElement *webLink in webLinkArray)
    {
        if([[[webLink attributeForName:@"rel"] stringValue] isEqualToString:@"alternate"])
        {
            image.photoImageUri = [[webLink attributeForName:@"href"] stringValue];
        }
        if([[[webLink attributeForName:@"rel"] stringValue] isEqualToString:@"enclosure"])
        {
            image.photoImageUri = [[webLink attributeForName:@"href"] stringValue];
            DebugLog(@"Photo Image URI : %@", image.photoImageUri);
            image.photoThumbnailUri = [self convertFlickrLargerImageUriToThumbnailImageUri:image.photoImageUri];
        }
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
        DebugLog(@"Buddy Icon URI : %@", author.buddyIcon);
    }
    return author;
}

- (NSString *)convertFlickrLargerImageUriToThumbnailImageUri:(NSString *)largerImageUri
{
    NSArray *filePathComponents = [largerImageUri componentsSeparatedByString:@"_"];
    NSMutableArray *mutableFilePathComponents = [NSMutableArray arrayWithArray:filePathComponents];
    NSString *lastObj = [mutableFilePathComponents lastObject];
    NSString *flickrEndingWithoutFileSizeIndicator = [lastObj substringFromIndex:1];
    NSString *newFlickrEndingWithThumbnailIndicator = [NSString stringWithFormat:@"t%@", flickrEndingWithoutFileSizeIndicator];
    [mutableFilePathComponents removeLastObject];
    [mutableFilePathComponents addObject:newFlickrEndingWithThumbnailIndicator];
    NSString *newFlickrThumbnailUri = [mutableFilePathComponents componentsJoinedByString:@"_"];
    return newFlickrThumbnailUri;
    
}

- (NSMutableArray *)divideModelArrayIntoNestedArraysForThumbnailView:(NSMutableArray *)arr
{
    NSMutableArray *arrayOfArrays = [NSMutableArray arrayWithCapacity:20];
    [arrayOfArrays addObject:[NSMutableArray arrayWithCapacity:4]];
    PBFlickrPicture *pic = nil;
    NSUInteger i, count = [arr count];
    for(i = 0; i < count; i ++)
    {
        DebugLog(@"PicObj image name : %@", pic.image.photoThumbnailUri);
        pic = (PBFlickrPicture *)[arr objectAtIndex:i];
        [[arrayOfArrays lastObject] addObject:pic];
        if(i != 0 && (count % 4) == 0){
            DebugLog(@"Creating new arr");
            [arrayOfArrays addObject:[NSMutableArray arrayWithCapacity:4]];
        }
    }
    return arrayOfArrays;
}

#pragma mark-
#pragma mark Begin PBFeedRequestDelegate methods

- (void)requestCompleted:(PBRequestConnection *)request withData:(NSData *)data
{
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
