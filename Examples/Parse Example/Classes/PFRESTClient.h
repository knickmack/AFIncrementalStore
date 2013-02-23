//
//  PFRESTClient.h
//  Parse Example
//
//  Created by Nik Macintosh on 2013-02-23.
//  Copyright (c) 2013 Nik Macintosh. All rights reserved.
//

#import "AFRESTClient.h"

@interface PFRESTClient : AFRESTClient

+ (PFRESTClient *)sharedClient;

@end
