//
//  PBMultiThumbnailCell.h
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/4/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PBMultiThumbnailCell : UITableViewCell{
    UIImageView *imageView1;
    UIImageView *imageView2;
    UIImageView *imageView3;
    UIImageView *imageView4;
}

@property (nonatomic, retain) UIImageView *imageView1;
@property (nonatomic, retain) UIImageView *imageView2;
@property (nonatomic, retain) UIImageView *imageView3;
@property (nonatomic, retain) UIImageView *imageView4;

@end
