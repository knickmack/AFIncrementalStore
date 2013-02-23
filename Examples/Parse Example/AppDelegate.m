//
//  AppDelegate.m
//  Parse Example
//
//  Created by Nik Macintosh on 2013-02-22.
//  Copyright (c) 2013 Nik Macintosh. All rights reserved.
//

#import "AppDelegate.h"
#import "PFIncrementalStore.h"
#import "GameScoresViewController.h"

@interface AppDelegate ()

@property (strong, nonatomic, readonly) GameScoresViewController *gameScoresViewController;
@property (strong, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic, readonly) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic, readonly) UINavigationController *navigationController;
@property (strong, nonatomic, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;

@end

@implementation AppDelegate

@synthesize gameScoresViewController = _gameScoresViewController;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize navigationController = _navigationController;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - AppDelegate

- (UIWindow *)window {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _window.rootViewController = self.navigationController;
    }
    
    return _window;
}

- (GameScoresViewController *)gameScoresViewController {
    if (!_gameScoresViewController) {
        _gameScoresViewController = [GameScoresViewController new];
    }
    
    return _gameScoresViewController;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
    
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (!_managedObjectModel) {
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"ParseExample" withExtension:@"momd"]];
    }
    
    return _managedObjectModel;
}

- (UINavigationController *)navigationController {
    if (!_navigationController) {
        _navigationController = [[UINavigationController alloc] initWithRootViewController:self.gameScoresViewController];
    }
    
    return _navigationController;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (!_persistentStoreCoordinator) {
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        
        AFIncrementalStore *incrementalStore = (AFIncrementalStore *)[_persistentStoreCoordinator addPersistentStoreWithType:[PFIncrementalStore type] configuration:nil URL:nil options:nil error:nil];
        NSError *error = nil;
        if (![incrementalStore.backingPersistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    
    return _persistentStoreCoordinator;
}

- (void)saveContext {
    NSError *error = nil;
    if (self.managedObjectContext.hasChanges && ![self.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    } 
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:8 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}

@end
