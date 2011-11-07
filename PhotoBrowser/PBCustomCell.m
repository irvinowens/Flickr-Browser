//
//  PBCustomCell.m
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/5/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

#import "PBCustomCell.h"

@implementation PBCustomCell

@synthesize image;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setBackgroundColor:[UIColor blackColor]];
    [self.textLabel setTextColor:[UIColor whiteColor]];
    [self.image loadPhotoThumbnailImage];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark-
#pragma mark Begin PBImageLoadingProtocol methods

- (void)imageLoadedSuccessfully:(PBImage *)imagePic
{
    self.imageView.image = imagePic.photoThumbnail;
    [self setNeedsDisplay];
}

#pragma mark-
#pragma mark End PBImageLoadingProtocol methods

@end
