//
//  AppDelegate.m
//  Parse Example
//
//  Created by Nik Macintosh on 2013-02-22.
//  Copyright (c) 2013 Nik Macintosh. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

#pragma mark - AppDelegate

- (UIWindow *)window {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    
    return _window;
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
