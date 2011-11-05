//
//  PBRequest.h
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/4/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

#import "PBConsts.h"
#import "PBRequestDelegate.h"

@protocol PBRequestDataDelegate;

/**
 * The PBRequest is the base implementation for creating a request
 * to an external service
 */


@interface PBRequestConnection : NSObject <PBNSURLConnectionDelegateProtocol>{
    __unsafe_unretained id <PBRequestDataDelegate> delegate;
    PBRequestDelegate *requestDelegate;
}

@property (nonatomic, assign) id <PBRequestDataDelegate> delegate;

/**
 * The delegate for the NSURLRequest
 */

@property (nonatomic, strong) PBRequestDelegate *requestDelegate;

/**
 * Initializes a request to a given url
 * @param (NSURL *)url takes an NSURL
 */

- (void)makeRequestToUrl:(NSURL *)url;

@end

@protocol PBRequestDataDelegate <NSObject>

/**
 * Tell the delegate method that the request was made
 * @param (PBRequest *)request The request that is in progress
 */

- (void)requestMade:(PBRequestConnection *)request;

/**
 * Tell the delegate the request completed and provide full data
 * @param (PBRequest *)request The request that was made
 * @param (NSData *)data The data from the request
 * @return The full data response
 */

- (void)requestCompleted:(PBRequestConnection *)request withData:(NSData *)data;

/**
 * The request could not be completed for some reason
 * @param (PBRequest *)request The request that was made and failed
 * @param (NSError *)error The error that happened
 */

- (void)request:(PBRequestConnection *)request experiencedError:(NSError *)error;

@end