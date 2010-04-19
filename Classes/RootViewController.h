//
//  RootViewController.h
//  todo
//
//  Created by Steve Aquillano on 4/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodoViewController.h"

@interface RootViewController : UITableViewController {

	TodoViewController *todoView;

}

@property(nonatomic,retain) TodoViewController *todoView;

@end
