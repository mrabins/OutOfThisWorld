//
//  OWOuterWorldTableViewController.h
//  Out Of This World
//
//  Created by Mark Rabins on 5/17/14.
//  Copyright (c) 2014 Mark Rabins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWAddSpaceObjectViewController.h"

@interface OWOuterWorldTableViewController : UITableViewController <OWAddSpaceObjectiveViewControllerDelegate>



@property (strong, nonatomic)NSMutableArray *planet;
@property (strong, nonatomic) NSMutableArray *addedSpaceObjects;

@end
