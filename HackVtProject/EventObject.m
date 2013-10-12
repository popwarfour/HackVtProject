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
        //Real PARSE
        self.eventDate = [dictionary objectForKey:@"event_date"];
        self.location = [dictionary objectForKey:@"event_location"];
        self.city = [dictionary objectForKey:@"event_city"];
        self.title = [dictionary objectForKey:@"event_name"];
        self.genre = [dictionary objectForKey:@"event_genre"];
        self.details = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum";//[dictionary objectForKey:@"event_description"];
        self.music = [dictionary objectForKey:@"music"];
        self.eventID = [[dictionary objectForKey:@"event_id"] integerValue];
        NSString *posterImageUrl = [dictionary objectForKey:@"poster_image_url"];
        if(posterImageUrl != nil && ![posterImageUrl isEqualToString:@""])
        {
            self.posterImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:posterImageUrl]]];
        }
    }
    
    return self;
}

-(id)initWithFakeData
{
    if(arc4random() % 2 == 0)
    {
        self.eventDate = [NSDate date];
    }
    else
    {
        //self.eventDate = [NSDate date];
    }
    
    if(arc4random() % 2 == 0)
    {
        self.location = @"Monkey House";
    }
    else
    {
        //self.location = @"Nectars";
    }
    
    if(arc4random() % 2 == 0)
    {
        self.city = @"Winooski";
    }
    else
    {
        //self.city = @"Burlington";
    }
    
    if(arc4random() % 2 == 0)
    {
        self.title = @"Crazy Music Event";
    }
    else
    {
        //self.title = @"Monkey House, Winooski Vermont";
    }
    
    if(arc4random() % 2 == 0)
    {
        self.genre = @"Metal";
    }
    else
    {
        //self.genre = @"Hip Hop";
    }
    
    self.music = [[NSMutableArray alloc] init];
    for(int i = 0; i < 20; i++)
    {
        NSDictionary *temp = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:@"http://images.handy.de/fundb/web/290/11152/82000864.mp3", @"Best Song Ever!", nil] forKeys:[NSArray arrayWithObjects:@"url", @"title", nil]];
        [self.music addObject:temp];
    }
    
    self.eventID = arc4random() % 20;
    
    
    if(arc4random() % 2 == 0)
    {
        self.posterImage = [UIImage imageNamed:@"samplePoster.jpeg"];
    }
    else
    {
        //self.posterImage = [UIImage imageNamed:@"samplePoster.jpeg"];
    }

    return self;
}

@end
