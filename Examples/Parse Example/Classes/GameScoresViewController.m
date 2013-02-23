//
//  GameScoresViewController.m
//  Parse Example
//
//  Created by Nik Macintosh on 2013-02-22.
//  Copyright (c) 2013 Nik Macintosh. All rights reserved.
//

#import "GameScoresViewController.h"
#import "GameScore.h"
#import "AppDelegate.h"

@interface GameScoresViewController () <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic, readonly) NSFetchRequest *fetchRequest;
@property (strong, nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic, readonly) UIBarButtonItem *refreshBarButtonItem;

- (void)refetchData;

@end

@implementation GameScoresViewController

@synthesize fetchRequest = _fetchRequest;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize refreshBarButtonItem = _refreshBarButtonItem;

#pragma mark - GameScoresViewController

- (NSFetchRequest *)fetchRequest {
    if (!_fetchRequest) {
        _fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"GameScore"];
        
        NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"score" ascending:YES selector:@selector(localizedStandardCompare:)];
        
        _fetchRequest.returnsObjectsAsFaults = NO;
        _fetchRequest.sortDescriptors = @[ descriptor ];
    }
    
    return _fetchRequest;
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (!_fetchedResultsController) {
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:self.fetchRequest managedObjectContext:[(AppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
        
        _fetchedResultsController.delegate = self;
    }
    
    return _fetchedResultsController;
}

- (UIBarButtonItem *)refreshBarButtonItem {
    if (!_refreshBarButtonItem) {
        _refreshBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refetchData)];
    }
    
    return _refreshBarButtonItem;
}

- (void)refetchData {
    self.fetchedResultsController.fetchRequest.resultType = NSManagedObjectResultType;
    [self.fetchedResultsController performFetch:nil];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> rows = [self.fetchedResultsController.sections objectAtIndex:section];
    
    return [rows numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    GameScore *gameScore = (GameScore *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.detailTextLabel.text = gameScore.score.stringValue;
    cell.textLabel.text = gameScore.playerName;
    
    return cell;
}

#pragma mark - UIViewController

- (void)loadView {
    [super loadView];
    
    self.navigationItem.rightBarButtonItem = self.refreshBarButtonItem;
    self.title = NSLocalizedString(@"GameScores", nil);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"%@ %@", error, error.localizedDescription);
        return;
    }
}

- (void)didReceiveMemoryWarning {
    _fetchRequest = nil;
    _fetchedResultsController = nil;
    
    [super didReceiveMemoryWarning];
}

@end
