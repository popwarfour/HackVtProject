//
//  EventObject.m
//  HackVtProject
//
//  Created by Jordan Rouille on 10/11/13.
//  Copyright (c) 2013 CSScrew. All rights reserved.
//

#import "EventObject.h"

@implementation EventObject

-(id)initWithJSONObject:(NSDictionary *)dictionary
{
    
    if(self = [super init])
    {
        if(arc4random() % 2 == 0)
        {
            self.title = @"Crazy Music Event";
        }
        else
        {
            self.title = @"Monkey House, Winooski Vermont";
        }
        
        if(arc4random() % 2 == 0)
        {
            self.memebers = [[NSMutableArray alloc] initWithObjects:@"John Doe", @"Kevin Bacon", @"Steve McAwesomePants", nil];
        }
        else
        {
            
        }
        
        if(arc4random() % 2 == 0)
        {
            self.posterImage = [UIImage imageNamed:@"samplePoster.jpeg"];
        }
        else
        {
            
        }
        
        if(arc4random() % 2 == 0)
        {
            self.details = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
        }
        else
        {
            self.details = @"really really really short details descriptions!";
        }
        
        if(arc4random() % 2 == 0)
        {
            self.eventDate = [NSDate date];
        }
        else
        {
            
        }
    }
    
    return self;
}

@end
