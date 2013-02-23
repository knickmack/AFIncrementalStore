//
//  PFRESTClient.m
//  Parse Example
//
//  Created by Nik Macintosh on 2013-02-23.
//  Copyright (c) 2013 Nik Macintosh. All rights reserved.
//

#import "PFRESTClient.h"

static NSString * const kPFRESTAPIBaseURLString = @"https://api.parse.com/1/";

@implementation PFRESTClient

#pragma mark - PFRESTClient

+ (PFRESTClient *)sharedClient {
    static PFRESTClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[PFRESTClient alloc] initWithBaseURL:[NSURL URLWithString:kPFRESTAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (NSString *)pathForEntity:(NSEntityDescription *)entity {
    NSString *path = [NSString stringWithFormat:@"classes/%@", entity.name];
    
    return path;
}

#pragma mark - AFHTTPClient

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

@end
