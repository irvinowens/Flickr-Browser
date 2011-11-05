//
//  PBRequestDelegate.m
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PBRequestDelegate.h"

@implementation PBRequestDelegate

@synthesize handler, receivedData;

- (id)initWithHandler:(id)myHandler
{
    if(self = [super init])
    {
        self.handler = myHandler;
        self.receivedData = [[NSMutableData alloc] initWithLength:20000];
    }
    return self;
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.receivedData = nil;
    if([handler respondsToSelector:@selector(connectionFailure:)])
    {
        [handler performSelector:@selector(connectionFailure:) withObject:error];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if([handler respondsToSelector:@selector(receivedData:)])
    {
        [handler performSelector:@selector(receivedData:) withObject:self.receivedData];
    }
}

@end
