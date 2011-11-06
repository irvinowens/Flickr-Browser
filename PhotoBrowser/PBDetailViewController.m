//
//  PBDetailViewController.m
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/3/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

#import "PBDetailViewController.h"

@interface PBDetailViewController ()
- (void)configureView;
@end

@implementation PBDetailViewController

@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize scrollView = _scrollView;
@synthesize imageView = _imageView;
@synthesize progressView = _progressView;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        [_detailItem.image setDelegate:self];
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        //[self.imageView setImage:self.detailItem.image.photoImage];
        [self.progressView setAlpha:1.0f];
        [self.detailItem.image loadPhotoImage];
        self.detailDescriptionLabel.text = [NSString stringWithFormat:@"Loading %@",self.detailItem.image.imageTitle];
        self.title = self.detailItem.image.imageTitle;
        [UIView animateWithDuration:3.0f 
                              delay:5.0f 
                            options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear) 
                         animations:^{
            [self.detailDescriptionLabel setAlpha:0.0f];
        } 
                         completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.imageView.image = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.imageView setImage:self.detailItem.image.photoThumbnail];
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark-
#pragma mark Begin PBImageLoadingProtocol methods

- (void)imageLoadedSuccessfully:(PBImage *)image
{
    [self.imageView setImage:self.detailItem.image.photoImage];
    [self.imageView setNeedsDisplay];
    [self.progressView setAlpha:0.0f];
}

#pragma mark-
#pragma mark End PBImageLoadingProtocol methods

@end
