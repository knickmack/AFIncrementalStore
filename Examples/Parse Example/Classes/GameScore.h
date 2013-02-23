//
//  GameScore.h
//  Parse Example
//
//  Created by Nik Macintosh on 2013-02-23.
//  Copyright (c) 2013 Nik Macintosh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface GameScore : NSManagedObject

@property (strong, nonatomic) NSNumber *cheatMode;
@property (strong, nonatomic) NSString *playerName;
@property (strong, nonatomic) NSNumber *score;

@end
