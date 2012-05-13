//
//  Tweet.m
//  JSRestNetworkKitSampleProject
//
//  Created by Javier Soto on 5/6/12.
//  Copyright (c) 2012 JavierSoto. All rights reserved.
//

#import "Tweet.h"

#import "TwitterUser.h"

@implementation Tweet

@synthesize user, text;

+ (NSArray *)entityProperties
{
    static NSMutableArray *entityProperties = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        entityProperties = [[NSMutableArray alloc] init];
        
        [entityProperties addObject:[JSEntityProperty entityPropertyWithKey:@"user" relationClass:[TwitterUser class] propertyType:JSEntityPropertyTypeRelationshipOneToOne]];
        [entityProperties addObject:[JSEntityProperty entityPropertyWithKey:@"text" propertyType:JSEntityPropertyTypeString]];
    });
    
    return entityProperties;
}

@end
