//
//  UIColor+methods.m
//  GoGreen
//
//  Created by Jordan Rouille on 9/3/13.
//  Copyright (c) 2013 Aidan Melen. All rights reserved.
//

#import "UIColor+methods.h"

@implementation UIColor (methods)

+(UIColor *)eventCellBackgroundColor
{
    return [UIColor colorWithRed:198.0f/255.0f green:255.0f/255.0f blue:203.0f/255.0f alpha:1];
}

+(UIColor *)segmentBackgroundColor
{
    return [UIColor colorWithRed:19.0f/255.0f green:122.0f/255.0f blue:28.0f/255.0f alpha:1];
}

+(UIColor *)eventDateColor
{
    return [UIColor colorWithRed:102.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1];
}
+(UIColor *)eventVenueColor
{
    return [UIColor colorWithRed:0.0f/255.0f green:102.0f/255.0f blue:0.0f/255.0f alpha:1];
}
+(UIColor *)eventLocationColor
{
    return [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:102.0f/255.0f alpha:1];
}
+(UIColor *)eventGenreColor
{
    return [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:0.0f/255.0f alpha:1];
}
+(UIColor *)eventDescriptionColor
{
    return [UIColor colorWithRed:208.0f/255.0f green:163.0f/255.0f blue:0.0f/255.0f alpha:1];
}


@end
