//
//  PBRequest.m
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/4/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

#import "PBRequestConnection.h"

@implementation PBRequestConnection

@synthesize delegate, requestDelegate;

- (id)init
{
    if(self = [super init])
    {
        
    }
    return self;
}

- (void)makeRequestToUrl:(NSURL *)url
{
    self.requestDelegate = [[PBRequestDelegate alloc] initWithHandler:self];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:url] 
                                                            delegate:self.requestDelegate 
                                                    startImmediately:NO];
    [conn start];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    if([self.delegate respondsToSelector:@selector(requestMade:)])
    {
        [self.delegate performSelector:@selector(requestMade:) withObject:self];
    }
}

#pragma mark-
#pragma mark Begin PBNSURLConnectionDelegateProtocol methods

- (void)receivedData:(NSData *)receivedData
{
    DebugLog(@"Received the data");
    if([self.delegate respondsToSelector:@selector(requestCompleted:withData:)])
    {
        [self.delegate performSelector:@selector(requestCompleted:withData:) 
                            withObject:self 
                            withObject:receivedData];
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)connectionFailure:(NSError *)error
{
    if([self.delegate respondsToSelector:@selector(request:experiencedError:)])
    {
        [self.delegate performSelector:@selector(request:experiencedError:) 
                            withObject:self 
                            withObject:error];
    }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark-
#pragma mark End PBNSURLConnectionDelegateProtocol methods

@end
