//
//  PBImageRequest.m
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PBImageRequest.h"

@implementation PBImageRequest

@synthesize imageRequestType;

- (void)dealloc
{
    self.delegate = nil;
}

@end
