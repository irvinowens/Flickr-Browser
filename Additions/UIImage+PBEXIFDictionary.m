//
//  UIImage+PBEXIFDictionary.m
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/6/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//
#import "PBConsts.h"
#import "UIImage+PBEXIFDictionary.h"
#import <CoreMedia/CoreMedia.h>
#import <ImageIO/ImageIO.h>

@implementation UIImage (PBEXIFDictionary)

- (NSDictionary *)exifDictionary
{
    CGImageRef cgimage = [self CGImage];
    CFDataRef dataRef = CGDataProviderCopyData(CGImageGetDataProvider(cgimage));
    CGImageSourceRef sourceRef = CGImageSourceCreateWithData(dataRef, NULL);
    NSDictionary *dict = (__bridge_transfer NSDictionary *) CGImageSourceCopyPropertiesAtIndex(sourceRef, 0, NULL);
    NSDictionary *exifDict = (NSDictionary *)[dict valueForKey:(id)kCGImagePropertyExifDictionary];
    return exifDict;
}

@end
