//
//  PBRequestDelegate.h
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/4/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

#import "PBConsts.h"

@protocol PBNSURLConnectionDelegateProtocol;

/**
 * The request delegate is a generic, overridable class to respond
 * to NSURLConnection inbound events
 */


@interface PBRequestDelegate : NSObject <NSURLConnectionDelegate>{
    id handler;
    NSMutableData *receivedData;
}

/**
 * The handler is the class to respond to inbound events
 */

@property (nonatomic, strong) id handler;

/**
 * Store for intermediate bytes of data, if necessary
 */

@property (strong) NSMutableData *receivedData;

/**
 * Just go ahead and initialize the connection delegate
 * with the class implementing the connection delegate format
 */

- (id)initWithHandler:(id)myHandler;

@end

@protocol PBNSURLConnectionDelegateProtocol <NSObject>

/**
 * Inform delegate that the connection failed with the 
 * error from the NSURLConnection
 * @param (NSError *)error The error
 */

- (void)connectionFailure:(NSError *)error;

/**
 * Send the completed data back to the delegate
 * @param (NSData *)receivedData The data received from the source
 */

- (void)receivedData:(NSData *)receivedData;

@end