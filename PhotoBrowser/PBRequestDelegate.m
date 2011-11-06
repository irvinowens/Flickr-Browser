//
//  PBRequestDelegate.m
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/4/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

#import "PBRequestDelegate.h"

@implementation PBRequestDelegate

@synthesize handler, receivedData;

- (id)initWithHandler:(id)myHandler
{
    if(self = [super init])
    {
        self.handler = myHandler;
        self.receivedData = [NSMutableData dataWithLength:0];
    }
    return self;
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    DebugLog(@"Error : %@", [error localizedDescription]);
    self.receivedData = nil;
    if([self.handler respondsToSelector:@selector(connectionFailure:)])
    {
        [self.handler performSelector:@selector(connectionFailure:) withObject:error];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.receivedData = [NSMutableData dataWithLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
    DebugLog(@"Did receive bytes size : %d", [data length]);
    if(self.receivedData == nil)
    {
        DebugLog(@"Received data is nil");
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if([self.handler respondsToSelector:@selector(receivedData:)])
    {
        [self.handler performSelector:@selector(receivedData:) withObject:self.receivedData];
    }
}

@end
