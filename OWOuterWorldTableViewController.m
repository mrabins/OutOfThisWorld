//
//  OWOuterWorldTableViewController.m
//  Out Of This World
//
//  Created by Mark Rabins on 5/17/14.
//  Copyright (c) 2014 Mark Rabins. All rights reserved.
//

#import "OWOuterWorldTableViewController.h"
#import "AstronomicalData.h"
#import "OWSpaceObject.h"
#import "OWSpaceImageViewController.h"
#import "OWSpaceDataViewController.h"

@interface OWOuterWorldTableViewController ()

@end

@implementation OWOuterWorldTableViewController

#define ADDED_SPACE_OBJECTS_KEY @"Added Space Objects Array"

#pragma mark - Lazy Instantiation of Properties

-(NSMutableArray *)planet
{
    if(!_planet){
        _planet = [[NSMutableArray alloc] init];
    }
    return _planet;
}

-(NSMutableArray *)addedSpaceObjects{
    if (!_addedSpaceObjects){
        _addedSpaceObjects = [[NSMutableArray alloc] init];
        
    }
    return _addedSpaceObjects;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
//    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    for (NSMutableDictionary *planetData in [AstronomicalData allKnownPlanets])
    {
        NSString *imageName = [NSString stringWithFormat:@"%@.jpg", planetData[PLANET_NAME]];
        OWSpaceObject *planet = [[OWSpaceObject alloc] initWithData:planetData andImage:[UIImage imageNamed:imageName]];
        [self.planet addObject:planet];
    }
    NSArray *myPlanetAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_SPACE_OBJECTS_KEY];
    for(NSDictionary *dictonary in myPlanetAsPropertyLists){
        OWSpaceObject *spaceObject = [self spaceObjectForDictionary:dictonary];
        [self.addedSpaceObjects addObject:spaceObject];
        
    }
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

{
    
    /* The prepareForSegue method is called right before the viewController transition occurs. Notice that we do introspection to ensure that the Segue is being triggered by the UITableViewCell. We then confirm that the destination ViewController is the OWSpaceImageViewController. Finally, we create a variable named nextViewController that points to our destination ViewController. Determine the indexPath of the selected cell and use that indexPath to access a OWSpaceObject in our planet array. Finally set the property spaceobject of the variable nextViewController equal to the selected object. */
    
    if ([sender isKindOfClass:[UITableViewCell class]])
        
    {
        if ([segue.destinationViewController isKindOfClass:[OWSpaceImageViewController class]])
            
        {
            OWSpaceImageViewController *nextViewController = segue.destinationViewController;
            NSIndexPath *path = [self.tableView indexPathForCell:sender];
            OWSpaceObject *selectedObject;
            if (path.section == 0){
                selectedObject = self.planet[path.row];
            }
            else if (path.section == 1){
                selectedObject = self.addedSpaceObjects[path.row];
            }
            nextViewController.spaceObject = selectedObject;
        }
    }
    
    /* The prepareForSegue method is called right before the viewController transition occurs. Notice that we do introspection to ensure that the Segue is being triggered by the proper sender. In this case we pass in the NSIndexPath of the accessory button pressed. We then confirm that the destination ViewController is the OWSpaceDataViewController. Finally, we create a variable named targetViewController that points to our destination ViewController. Determine the indexPath of the selected cell and use that indexPath to access a OWSpaceObject in our planet array. Finally set the property spaceobject of the variable targetViewController equal to the selected object. */
    
    if ([sender isKindOfClass:[NSIndexPath class]])
        
    {
        if ([segue.destinationViewController isKindOfClass:[OWSpaceDataViewController class]])
        {
            OWSpaceDataViewController *targetViewController = segue.destinationViewController;
            NSIndexPath *path = sender;
            OWSpaceObject *selectedObject;
            
            if (path.section == 0){
                selectedObject = self.planet[path.row];
            }
            
            else if (path.section == 1){
                selectedObject = self.addedSpaceObjects[path.row];
            }
            
            targetViewController.spaceObject = selectedObject;
        }
    }
    
    /* If the destination ViewController is the addSpaceObjectVC we create a variable that points to the OWAddSpaceObjectViewController instance. With this instance we can set the delegate property so that the OWAddSpaceObjectViewController can call the methods defined in its' protocol. */
    
    if ([segue.destinationViewController isKindOfClass:[OWAddSpaceObjectViewController class]]){
        OWAddSpaceObjectViewController *addSpaceObjectVC = segue.destinationViewController;
        addSpaceObjectVC.delegate = self;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - OWAddSpaceObjectViewController Delegate

-(void)didCancel
{
    NSLog(@"didCancel");
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)addSpaceObject:(OWSpaceObject *)spaceObject
{
    [self.addedSpaceObjects addObject:spaceObject];
    
// Will save to NSUserDefaults Here
    
    NSMutableArray *spaceObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_SPACE_OBJECTS_KEY] mutableCopy];
    if(!spaceObjectsAsPropertyLists) spaceObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    [spaceObjectsAsPropertyLists addObject:[self spaceObjectAsAPropertyList: spaceObject]];
    
    [[NSUserDefaults standardUserDefaults] setObject:spaceObjectsAsPropertyLists forKey:ADDED_SPACE_OBJECTS_KEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];

    [self.tableView reloadData];
}

# pragma mark - Helper Methods

-(NSDictionary *)spaceObjectAsAPropertyList:(OWSpaceObject *)spaceObject
{
    NSData *imageData = UIImagePNGRepresentation(spaceObject.spaceImage);
    NSDictionary *dictionary = @{PLANET_NAME : spaceObject.name, PLANET_GRAVITY : @(spaceObject.gravitationalforce), PLANET_DIAMETER : @(spaceObject.diameter), PLANET_YEAR_LENGTH : @(spaceObject.yearLength), PLANET_DAY_LENGTH : @(spaceObject.dayLength), PLANET_TEMPERATURE : @(spaceObject.temperature), PLANET_NUMBER_OF_MOONS : @(spaceObject.numberOfMoons), PLANET_NICKNAME : spaceObject.nickname, PLANET_INTERESTING_FACT : spaceObject.interestingFact, PLANET_IMAGE : imageData };
    
    return dictionary;
    
}

-(OWSpaceObject *)spaceObjectForDictionary:(NSDictionary *)dictionary
{
    NSData *dataForImage = dictionary [PLANET_IMAGE];
    UIImage *spaceObjectImage = [UIImage imageWithData:dataForImage];
    OWSpaceObject *spaceObject = [[OWSpaceObject alloc] initWithData:dictionary andImage:spaceObjectImage];
                                  return spaceObject;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    if ([self.addedSpaceObjects count]){
        return 2;
    }
    else{
        return 1;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (section == 1){
        return  [self.addedSpaceObjects count];
        
    }
    else{
        return [self.planet count];
        
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //Configure the cell...
    if (indexPath.section ==1){
        //use new Space object to customize our cell
        OWSpaceObject *planet = [self.addedSpaceObjects objectAtIndex:indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickname;
        cell.imageView.image = planet.spaceImage;
    }
    else{
        
        OWSpaceObject *planet = [self.planet objectAtIndex:indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickname;
        cell.imageView.image = planet.spaceImage;
        
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];

    return cell;
}

#pragma mark UITableView Delegate

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"push to space data" sender:indexPath];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==1) { return YES;
    }
    else return NO;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.addedSpaceObjects removeObjectAtIndex:indexPath.row];
        
        NSMutableArray *newSaveSpaceObjectData = [[NSMutableArray alloc] init];
        for(OWSpaceObject *spaceObject in self.addedSpaceObjects){
            [newSaveSpaceObjectData addObject:[self spaceObjectAsAPropertyList:spaceObject]];
        }
        [[NSUserDefaults standardUserDefaults] setObject:newSaveSpaceObjectData forKey:ADDED_SPACE_OBJECTS_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}



// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
