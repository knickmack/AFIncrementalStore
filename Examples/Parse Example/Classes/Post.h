//
//  Post.h
//  Parse Example
//
//  Created by Nik Macintosh on 2013-02-23.
//  Copyright (c) 2013 Nik Macintosh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment;

@interface Post : NSManagedObject

@property (strong, nonatomic) NSSet *comments;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *title;

@end

@interface Post (CoreDataGeneratedAccessors)

- (void)addComments:(NSSet *)values;
- (void)addCommentsObject:(Comment *)value;
- (void)removeComments:(NSSet *)values;
- (void)removeCommentsObject:(Comment *)value;

@end
