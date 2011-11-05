//
//  RequestFactory.h
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/4/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

#import "PBConsts.h"
#import "PBRequest.h"
#import "PBFeedRequest.h"
#import "PBImageRequest.h"

/**
 * The PBRequestFactory creates request objects to be used
 * elsewhere in the application
 */


@interface PBRequestFactory : NSObject{
    
}

/**
 * Create the appropriate request object for a given type and delegate
 * @param (int)type The type of request object to be created
 * @param (id)delegate The request delegate
 */

+(PBRequest *)makeRequestWith:(int)type andDelegate:(id)delegate;

@end
