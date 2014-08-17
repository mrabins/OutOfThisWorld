//
//  OWSpaceObject.h
//  Out Of This World
//
//  Created by Mark Rabins on 5/26/14.
//  Copyright (c) 2014 Mark Rabins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWSpaceObject : NSObject

@property (strong, nonatomic)NSString *name;
@property (nonatomic) float gravitationalforce;
@property (nonatomic) float diameter;
@property (nonatomic) float yearLength;
@property (nonatomic) float dayLength;
@property (nonatomic) float temperature;
@property (nonatomic) int numberOfMoons;
@property (strong, nonatomic) NSString *nickname;
@property (strong, nonatomic) NSString *interestingFact;

@property (strong, nonatomic) UIImage *spaceImage;





-(id)initWithData:(NSDictionary *)data andImage:(UIImage*)image;



@end
