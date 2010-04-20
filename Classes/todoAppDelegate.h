//
//  todoAppDelegate.h
//  todo
//
//  Created by Steve Aquillano on 4/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "Todo.h"

@interface todoAppDelegate : NSObject <UIApplicationDelegate> {
    
    IBOutlet UIWindow *window;
    IBOutlet UINavigationController *navigationController;
	
	sqlite3 *database;
	// An array to hold all of the todo items
	NSMutableArray *todos;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSMutableArray *todos;

- (Todo *)addTodo;
- (void)removeTodo:(Todo *)todo;

@end

