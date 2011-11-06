//
//  PBDetailViewController.h
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/3/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBFlickrPicture.h"

@interface PBDetailViewController : UIViewController<PBImageLoadingProtocol>

@property (strong, nonatomic) PBFlickrPicture *detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *progressView;

@end
