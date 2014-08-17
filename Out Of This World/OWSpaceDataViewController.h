//
//  OWSpaceDataViewController.h
//  Out Of This World
//
//  Created by Mark Rabins on 6/3/14.
//  Copyright (c) 2014 Mark Rabins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWSpaceObject.h"

@interface OWSpaceDataViewController : UIViewController < UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) OWSpaceObject *spaceObject;


@end
