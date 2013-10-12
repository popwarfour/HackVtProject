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
        self.eventDate = [dictionary objectForKey:@"date"];
        self.location = [dictionary objectForKey:@"location"];
        self.city = [dictionary objectForKey:@"city"];
        self.title = [dictionary objectForKey:@"title"];
        self.genre = [dictionary objectForKey:@"genre"];
        self.music = [dictionary objectForKey:@"music"];
        self.eventID = [[dictionary objectForKey:@"eventID"] integerValue];
        self.posterImage = [dictionary objectForKey:@"posterImage"];
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
    for(int i = 0; i < 10; i++)
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
