//
//  Todo.h
//  todo
//
//  Created by Steve Aquillano on 4/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface Todo : NSObject
{
	sqlite3 *database;
	NSInteger primaryKey;
	NSString *text;
	NSInteger priority;
}

@property (assign, nonatomic, readonly) NSInteger primaryKey;
@property (nonatomic, retain) NSString *text;
@property (nonatomic) NSInteger priority;

- (id)initWithPrimaryKey:(NSInteger)pk database:(sqlite3 *)db;

@end