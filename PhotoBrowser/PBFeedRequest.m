//
//  PBFeedRequest.m
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PBFeedRequest.h"

@implementation PBFeedRequest

- (id)initWithDelegate:(id)del
{
    if(self = [super init])
    {
        self.delegate = del;
        [self makeRequestToUrl:[NSURL URLWithString:kFLICKR_API_URI]];
    }
    return self;
}

@end
