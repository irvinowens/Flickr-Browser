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
        self.receivedData = [NSMutableData dataWithLength:20000];
    }
    return self;
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.receivedData = nil;
    if([self.handler respondsToSelector:@selector(connectionFailure:)])
    {
        [self.handler performSelector:@selector(connectionFailure:) withObject:error];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    DebugLog(@"Did Receive response");
    self.receivedData = [NSMutableData dataWithLength:20000];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
    DebugLog(@"Did receive bytes size : %d", [data length]);
    DebugLog(@"Total data bytes size : %d", [self.receivedData length]);
#ifdef DEBUG_MODE
    NSString *str = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    DebugLog(@"Block %@", str);
    if(self.receivedData == nil)
    {
        DebugLog(@"Received data is nil");
    }
#endif
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
#ifdef DEBUG_MODE
    NSString *str = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    DebugLog(@"Response %@", str);
#endif
    if([self.handler respondsToSelector:@selector(receivedData:)])
    {
        [self.handler performSelector:@selector(receivedData:) withObject:self.receivedData];
    }
}

@end
