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
	NSInteger status;
	BOOL dirty;
}

@property (assign, nonatomic, readonly) NSInteger primaryKey;
@property (nonatomic, retain) NSString *text;
@property (nonatomic) NSInteger priority;
@property (nonatomic) NSInteger status;

- (id)initWithPrimaryKey:(NSInteger)pk database:(sqlite3 *)db;
- (void)updateStatus:(NSInteger) newStatus;
- (void)updatePriority:(NSInteger) newPriority;
- (void)dehydrate;
- (void)deleteFromDatabase;

// '+' indicates a static method
// Associated with the class, not an instance
// I can call this method without instantiating this class
+ (NSInteger)insertNewTodoIntoDatabase:(sqlite3 *)database;

@end