//
//  OWSpaceImageViewController.h
//  Out Of This World
//
//  Created by Mark Rabins on 5/31/14.
//  Copyright (c) 2014 Mark Rabins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWSpaceObject.h"

@interface OWSpaceImageViewController : UIViewController <UIScrollViewDelegate>


@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) OWSpaceObject *spaceObject;


@end
