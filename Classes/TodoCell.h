//
//  TodoCell.h
//  Todo
//
//  Created by Steve Aquillano on 4/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Todo.h"


@interface TodoCell : UITableViewCell
{
	// Not a property because it needs to be private
	// Disallow setting via cell.todo = foo;
	Todo		*todo;
	
	UILabel		*todoTextLabel;
	UILabel		*todoPriorityLabel;
	UIImageView	*todoPriorityImageView;
}

@property (nonatomic, retain) UILabel		*todoTextLabel;
@property (nonatomic, retain) UILabel		*todoPriorityLabel;
@property (nonatomic, retain) UIImageView	*todoPriorityImageView;

- (UIImage *)imageForPriority:(NSInteger)priority;

// Custom getter/setter methods for Todo objects
// The setter will contain additional code besides just assigning the todo object
- (Todo *)todo;
- (void)setTodo:(Todo *)newTodo;

@end
