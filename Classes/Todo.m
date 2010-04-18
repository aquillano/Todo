//
//  Todo.m
//  todo
//
//  Created by Steve Aquillano on 4/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Todo.h"

// Static means it is independent from any instance
// This holds the statement for retrieving todo data from the database
static sqlite3_stmt *init_statement = nil;

@implementation Todo

// Automate creating getter and setter methods.
@synthesize primaryKey, text, priority;

-(id)initWithPrimaryKey:(NSInteger)pk database:(sqlite3 *)db
{
	if (self = [super init])
	{
		primaryKey = pk; // Set to the passed in parameter
		database = db; // Set to the passed in parameter
		
		// Create the query for retrieving data from the db
		// Check if the init_statement is null
		// Happens once per application launch
		if (init_statement == nil)
		{
			// Note the '?' at the end of the query. This a parameter that can be replaced by a variable.
			// This provides optimization. Query is compiled once, then with each use new variables
			// can be substituted for the placeholder(s)
			// Create ONE generic SQL statement
			const char *sql = "SELECT text,priority FROM todo WHERE pk=?";
			// Prepare SQL statement and store it in 'init_statement'
			// if statement checks to if this was successful and prints an error msg if the was a problem.
			if (sqlite3_prepare_v2(database, sql, -1, &init_statement, NULL) != SQLITE_OK)
			{
				NSAssert1(0, @"Error, failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
			}
		}
		// For this query, bind the primary key to the first (only) placeholder in the statement.
		// Parameters are numbered from 1 (not 0).
		sqlite3_bind_int(init_statement, 1, primaryKey);
		// This method executes the SQL query statement on the database
		if (sqlite3_step(init_statement) == SQLITE_ROW)
		{
			// Make a string of the data retrieved from the database
			self.text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 0)];
			self.priority = sqlite3_column_int(init_statement, 1);
		}
		else
		{
			self.text = @"Nothing";	
		}
		// Reset the statement to use again later
		sqlite3_reset(init_statement);
	}
	return self;
}

@end
