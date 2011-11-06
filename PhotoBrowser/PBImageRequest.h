//
//  PBImageRequest.h
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PBRequestConnection.h"

@interface PBImageRequest : PBRequestConnection{
    int imageRequestType;
}

@property (nonatomic) int imageRequestType;

@end
