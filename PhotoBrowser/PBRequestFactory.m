//
//  RequestFactory.m
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/4/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

#define kFEED     1
#define kIMAGE    2

#import "PBRequestFactory.h"

@implementation PBRequestFactory

+(PBRequest *)makeRequestWith:(int)type andDelegate:(id)delegate
{
    PBRequest *req = nil;
    switch(type)
    {
        case kFEED:
        {
            PBFeedRequest *feed = [[PBFeedRequest alloc] initWithDelegate:delegate];
            req = feed;
        }
        break;
        case kIMAGE:
        {
            PBImageRequest *image = [[PBImageRequest alloc] init];
            [image setDelegate:delegate];
            req = image;
        }
        break;
    }
    return req;
}

@end
