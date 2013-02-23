//
//  PFIncrementalStore.m
//  Parse Example
//
//  Created by Nik Macintosh on 2013-02-23.
//  Copyright (c) 2013 Nik Macintosh. All rights reserved.
//

#import "PFIncrementalStore.h"
#import "PFRESTClient.h"

@implementation PFIncrementalStore

#pragma mark - AFIncrementalStore

- (id<AFIncrementalStoreHTTPClient>)HTTPClient {
    return [PFRESTClient sharedClient];
}

+ (NSManagedObjectModel *)model {
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"ParseExample" withExtension:@"momd"]];
}

+ (NSString *)type {
    return NSStringFromClass(self);
}

#pragma mark - NSObject

+ (void)initialize {
    [NSPersistentStoreCoordinator registerStoreClass:self forStoreType:[self type]];
}

@end
