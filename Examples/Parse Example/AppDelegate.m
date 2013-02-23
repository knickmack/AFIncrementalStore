//
//  AppDelegate.m
//  Parse Example
//
//  Created by Nik Macintosh on 2013-02-22.
//  Copyright (c) 2013 Nik Macintosh. All rights reserved.
//

#import "AppDelegate.h"
#import "GameScoresViewController.h"

@interface AppDelegate ()

@property (strong, nonatomic, readonly) GameScoresViewController *gameScoresViewController;
@property (strong, nonatomic, readonly) UINavigationController *navigationController;

@end

@implementation AppDelegate

@synthesize gameScoresViewController = _gameScoresViewController;
@synthesize navigationController = _navigationController;

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

- (UINavigationController *)navigationController {
    if (!_navigationController) {
        _navigationController = [[UINavigationController alloc] initWithRootViewController:self.gameScoresViewController];
    }
    
    return _navigationController;
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
