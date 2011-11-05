//
//  PBFeedRequest.h
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PBRequest.h"

@interface PBFeedRequest : PBRequest

/**
 * Initialize a new feed request object with
 * a delegate assigned
 */

- (id)initWithDelegate:(id)del;

@end
