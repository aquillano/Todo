//
//  RootViewController.m
//  todo
//
//  Created by Steve Aquillano on 4/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "RootViewController.h"
#import "todoAppDelegate.h"
#import "Todo.h"
#import "TodoCell.h"


@implementation RootViewController

@synthesize todoView;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Todo Items";
	//[self.tableView reloadData];
	

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)viewWillAppear:(BOOL)animated
{
	[self.tableView reloadData];
    [super viewWillAppear:animated];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	todoAppDelegate *appDelegate = (todoAppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.todos.count;
}



// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifier = @"MyIdentifier";
    
    TodoCell *cell = (TodoCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) {
		cell = [[[TodoCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
	}
    
	todoAppDelegate *appDelegate = (todoAppDelegate *)[[UIApplication sharedApplication] delegate];
	Todo *td = [appDelegate.todos objectAtIndex:indexPath.row];
	
	[cell setTodo:td];
	
	// Set up the cell
    return cell;
}



// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here -- for example, create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController animated:YES];
	// [anotherViewController release];
	
	todoAppDelegate *appDelegate = (todoAppDelegate *)[[UIApplication sharedApplication] delegate];
	Todo *todo = (Todo *)[appDelegate.todos objectAtIndex:indexPath.row];
	
	if (self.todoView == nil) {
		TodoViewController *viewController = [[TodoViewController alloc] initWithNibName:@"TodoViewController" bundle:[NSBundle mainBundle]];
		self.todoView = viewController;
		[viewController release];
	}
	
	[self.navigationController pushViewController:self.todoView animated:YES];
	self.todoView.todo = todo;
	self.todoView.title = todo.text;
	[self.todoView.todoText setText:todo.text];
	
	NSInteger priority = todo.priority -1;
	if (priority > 2 || priority <0) {
		priority = 1;
	}
	priority = 2 - priority;
	
	[self.todoView.todoPriority setSelectedSegmentIndex:priority];
	
	if (todo.status == 1) {
		[self.todoView.todoButton setTitle:@"Mark As In Progress" forState:UIControlStateNormal];
		[self.todoView.todoButton setTitle:@"Mark As In Progress" forState:UIControlStateHighlighted];
		[self.todoView.todoStatus setText:@"Complete"];
	}
	else {
		[self.todoView.todoButton setTitle:@"Mark As In Complete" forState:UIControlStateNormal];
		[self.todoView.todoButton setTitle:@"Mark As In Complete" forState:UIControlStateHighlighted];
		[self.todoView.todoStatus setText:@"In Progress"];
	}
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
    [super dealloc];
}


@end

