//
//  UIFont+UIFont.m
//  GoGreen
//
//  Created by Jordan Rouille on 9/3/13.
//  Copyright (c) 2013 Aidan Melen. All rights reserved.
//

#import "UIFont+methods.h"

@implementation UIFont (UIFont)

#pragma mark - EVENT CELL FONTS

+(UIFont *)eventsCellTitle
{
    return [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20];
}

+(UIFont *)eventsCellOther
{
    return [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:15];
}

#pragma mark - EVENT DETAILS FONTS

+(UIFont *)eventsDetailTitle
{
    return [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20];
}

+(UIFont *)eventsDetailDetails
{
    return [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:12];
}

+(UIFont *)eventsDetailsMemebers
{
    return [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:14];
}

@end
