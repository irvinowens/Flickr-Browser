//
//  PBRequest.m
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/4/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

#import "PBRequest.h"

@implementation PBRequest

@synthesize delegate;

- (id)init
{
    if(self = [super init])
    {
        
    }
    return self;
}

- (void)makeRequestToUrl:(NSURL *)url
{
    PBRequestDelegate *reqDel = [[PBRequestDelegate alloc] initWithHandler:self];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:url] 
                                                            delegate:reqDel 
                                                    startImmediately:NO];
    [conn start];
    if([self.delegate respondsToSelector:@selector(requestMade:)])
    {
        [self.delegate performSelector:@selector(requestMade:) withObject:self];
    }
}

#pragma mark-
#pragma mark Begin PBNSURLConnectionDelegateProtocol methods

- (void)receivedData:(NSData *)receivedData
{
    if([self.delegate respondsToSelector:@selector(requestCompleted:)])
    {
        [self.delegate performSelector:@selector(requestCompleted:withData:) 
                            withObject:self 
                            withObject:receivedData];
    }
}

- (void)connectionFailure:(NSError *)error
{
    if([self.delegate respondsToSelector:@selector(request:experiencedError:)])
    {
        [self.delegate performSelector:@selector(request:experiencedError:) 
                            withObject:self 
                            withObject:error];
    }
}

#pragma mark-
#pragma mark End PBNSURLConnectionDelegateProtocol methods

@end
