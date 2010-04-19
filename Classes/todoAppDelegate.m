//
//  todoAppDelegate.m
//  todo
//
//  Created by Steve Aquillano on 4/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "todoAppDelegate.h"
#import "RootViewController.h"
#import "Todo.h"

// Specific to this object
// Do not need to declare in the .h file
@interface todoAppDelegate (Private)

- (void)createEditableCopyOfDatabaseIfNeeded;
- (void)initializeDatabase;

@end


@implementation todoAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize todos;

- (id)init {
	if (self = [super init]) {
		// 
	}
	return self;
}


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch
	[self createEditableCopyOfDatabaseIfNeeded];
	[self initializeDatabase];
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
	[todos makeObjectsPerformSelector:@selector(dehydrate)];
}


#pragma mark -
#pragma mark Memory management


// Creates a writeable copy of the bundled default database
// in the application Documents directory.
// Copies the database from your project folder to
// the Documents directory on your iPhone
// Happens once as it first checks it the database already exists
// in the documents folder.
- (void)createEditableCopyOfDatabaseIfNeeded
{
	// First, test for existence
	BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"todo.sqlite"];
	success = [fileManager fileExistsAtPath:writableDBPath];
	if (success) return;
	// The writable database does not exist, so copy the default
	// to the appropriate location.
	NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"todo.sqlite"];
	success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
	if (!success)
	{
		NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}
}


// Open the database connection and retrieve basic information for all objects.
- (void)initializeDatabase
{
	NSMutableArray *todoArray = [[NSMutableArray alloc] init];
	self.todos = todoArray;
	[todoArray release];
	
	// The database is stored in the application bundle.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"todo.sqlite"];
	
	// Open the database. The database was prepared outside the application
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK)
	{
		// Get the primary key for all todo items
		const char *sql = "SELECT pk from todo";
		sqlite3_stmt *statement;
		// Preparing a statement compiles the SQL query into a byte-code program in the SQLite library.
		// The third parameter is either the lenght of the SQL string or -1 to read up to the first null terminator.
		if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK)
		{
			// "Step" through teh results one row at a time.
			while (sqlite3_step(statement) == SQLITE_ROW)
			{
				// The second parameter indicates the column index in result set of pk
				int primaryKey = sqlite3_column_int(statement, 0);
				// The alloc-init-autorelease pattern is avoided here because we are in a tight loop and
				// autorelease is slightly more expensive than release. This design choice has nothing to do with
				// acutal memory management - at the end of this block of code, all the todo objects allocated
				// here will be in memory regardless of whether you use autorelease or release, because they are
				// retained by the todo array.
				Todo *td = [[Todo alloc] initWithPrimaryKey:primaryKey database:database];
				[todos addObject:td];
				[td release];
			}
		}
		// "Finalize" the statement - releases the resources asscoiate with the statement.
		sqlite3_finalize(statement);
	}
	else
	{
	   // Even though the open failed, call close to properly clean up resources.
	   sqlite3_close(database);
	   NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
	   // Additional error handing if needed...
	}
	//NSLog([[NSString alloc] initWithFormat:@"size:'%@'",[[todos objectAtIndex:3] text]]);
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

