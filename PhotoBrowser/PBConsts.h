//
//  PBConsts.h
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/4/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

/**
 * Define constants to be used application wide such as url strings
 */

/**
 * Define debug mode to output statements that will be useful
 * in debugging
 */

#define DEBUG_MODE

#ifdef DEBUG_MODE
#define DebugLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DebugLog( s, ... ) 
#endif

/**
 * The flickr public api uri
 */

extern NSString * const kFLICKR_API_URI;

/**
 * The feed request type for the factory
 */

extern int const kFEED_REQUEST_TYPE;

/**
 * The image request type for the factory
 */

extern int const kIMAGE_REQUEST_TYPE;

@interface PBConsts : NSObject

@end
