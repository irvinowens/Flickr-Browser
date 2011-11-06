//
//  PBCustomCell.h
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/5/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBImage.h"
#import "PBFlickrPicture.h"

@interface PBCustomCell : UITableViewCell <PBImageLoadingProtocol>{
    PBImage *image;
}

@property (nonatomic, strong) PBImage *image;

@end
