//
//  GameScoresViewController.m
//  Parse Example
//
//  Created by Nik Macintosh on 2013-02-22.
//  Copyright (c) 2013 Nik Macintosh. All rights reserved.
//

#import "GameScoresViewController.h"
#import "AppDelegate.h"

@interface GameScoresViewController () <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic, readonly) NSFetchRequest *fetchRequest;
@property (strong, nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;

@end

@implementation GameScoresViewController

@synthesize fetchRequest = _fetchRequest;
@synthesize fetchedResultsController = _fetchedResultsController;

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

#pragma mark - UIViewController

- (void)loadView {
    [super loadView];
    
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
