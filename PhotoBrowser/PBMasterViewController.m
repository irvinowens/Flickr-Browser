//
//  PBMasterViewController.m
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/3/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

#import "PBMasterViewController.h"

#import "PBDetailViewController.h"

@interface PBMasterViewController ()
- (void)configureCell:(PBCustomCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation PBMasterViewController

@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize provider, imageGrid;

- (void)awakeFromNib
{
    [super awakeFromNib];
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
    // Set up the edit and add buttons.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadData)];
    if(self.provider == nil)
    {
        self.provider = [[PBDataProvider alloc] init];
        [self.provider setDelegate:self];
        [self.provider updateDataWithPullFromFeed];
    }
}

- (void)reloadData
{
    [self.provider updateDataWithPullFromFeed];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.imageGrid = nil;
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

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.imageGrid count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

// Customize the appearance of table view cells.
- (PBCustomCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    PBCustomCell *cell = (PBCustomCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.imageView.image = [UIImage imageNamed:@"377621-sil.png"];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [[segue destinationViewController] setDetailItem:[self.imageGrid objectAtIndex:indexPath.row]];
    }
}

- (void)configureCell:(PBCustomCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    DebugLog(@"Index Path Row : %d", indexPath.row);
    PBFlickrPicture *pic = [self.imageGrid objectAtIndex:indexPath.row];
    DebugLog(@"Text Label : %@", pic.image.imageTitle);
    pic.image.delegate = cell;
    cell.image = pic.image;
    [cell.textLabel setText:pic.image.imageTitle];
}

#pragma mark-
#pragma mark Begin PBDataProviderConsumerProtocol

- (void)provider:(PBDataProvider *)provider receivedAndProcessedModelObjects:(NSMutableArray *)modelObjects
{
    [self.tableView reloadData];
    self.imageGrid = modelObjects;
    [self.tableView reloadData];
}

#pragma mark End PBDataProviderConsumerProtocol
#pragma mark-

@end
