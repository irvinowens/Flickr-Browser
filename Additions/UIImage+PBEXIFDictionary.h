//
//  UIImage+PBEXIFDictionary.h
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/6/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

/**
 * A category on UIImage to get the exif data dictionary
 */


@interface UIImage (PBEXIFDictionary)

/**
 * Returns a dicitonary of exif data from a given
 * UIImage
 */

- (NSDictionary *)exifDictionary;

@end
