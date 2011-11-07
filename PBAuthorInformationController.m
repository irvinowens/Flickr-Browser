//
//  PBAuthorInformationController.m
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/6/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

#import "PBAuthorInformationController.h"


@implementation PBAuthorInformationController

@synthesize picture, request;
@synthesize myTableView = _myTableView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [self configureCell:cell indexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        cell.imageView.autoresizesSubviews = YES;
        cell.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        cell.textLabel.text = picture.author.name;
        cell.imageView.image = [UIImage imageNamed:@"377621-sil.png"];
        self.request = [PBRequestFactory makeRequestWith:kIMAGE_REQUEST_TYPE andDelegate:self];
        DebugLog(@"Buddy Uri : %@", picture.author.buddyIcon );
        [self.request makeRequestToUrl:[NSURL URLWithString:picture.author.buddyIcon]];
    }else if(indexPath.row == 1){
        cell.textLabel.text = @"Author Profile";
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.picture.author.profileUri]];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark-
#pragma mark Begin PBNSURLConnectionDelegateProtocol methods

- (void)requestMade:(PBRequestConnection *)request
{
    
}

- (void)requestCompleted:(PBRequestConnection *)request withData:(NSData *)data;
{
    DebugLog(@"Received the data %d", [data length]);
    UIImage *img = [[UIImage alloc] initWithData:data];
    UITableViewCell *cell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.imageView setImage:img];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)request:(PBRequestConnection *)request experiencedError:(NSError *)error
{
    DebugLog(@"Request Error : %@", [error description]);
}

#pragma mark-
#pragma mark End PBNSURLConnectionDelegateProtocol methods

@end
