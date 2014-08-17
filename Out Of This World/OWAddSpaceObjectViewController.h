//
//  OWAddSpaceObjectViewController.h
//  Out Of This World
//
//  Created by Mark Rabins on 6/4/14.
//  Copyright (c) 2014 Mark Rabins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWSpaceObject.h"

@protocol OWAddSpaceObjectiveViewControllerDelegate <NSObject>

@required

-(void)addSpaceObject:(OWSpaceObject *)spaceObject;
-(void)didCancel;

@end

@interface OWAddSpaceObjectViewController : UIViewController

@property (weak, nonatomic) id <OWAddSpaceObjectiveViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *nicknameTextField;
@property (strong, nonatomic) IBOutlet UITextField *diameterTextField;
@property (strong, nonatomic) IBOutlet UITextField *tempertureTextField;
@property (strong, nonatomic) IBOutlet UITextField *numberOfMoonsTextField;
@property (strong, nonatomic) IBOutlet UITextField *interestingFactTextField;

- (IBAction)addButtonPressed:(id)sender;

- (IBAction)cancelButtonPressed:(UIButton *)sender;


@end
