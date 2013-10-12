//
//  EventObject.m
//  HackVtProject
//
//  Created by Jordan Rouille on 10/11/13.
//  Copyright (c) 2013 CSScrew. All rights reserved.
//

#import "EventObject.h"

@implementation EventObject

#define BASEURL @"http://192.168.8.246/hackvt/HackVtProject/"

-(id)initWithJSONObject:(NSDictionary *)dictionary
{
    
    if(self = [super init])
    {
        //Real PARSE
        if(![[dictionary objectForKey:@"event_date"] isEqual:[NSNull null]])
        {
            self.eventDate = [dictionary objectForKey:@"event_date"];
        }
        if(![[dictionary objectForKey:@"event_location"] isEqual:[NSNull null]])
        {
            self.location = [dictionary objectForKey:@"event_location"];
        }
        if(![[dictionary objectForKey:@"event_city"] isEqual:[NSNull null]])
        {
            self.city = [dictionary objectForKey:@"event_city"];
        }
        if(![[dictionary objectForKey:@"event_name"] isEqual:[NSNull null]])
        {
            self.title = [dictionary objectForKey:@"event_name"];
        }
        if(![[dictionary objectForKey:@"event_genre"] isEqual:[NSNull null]])
        {
            self.genre = [dictionary objectForKey:@"event_genre"];
        }
        if(![[dictionary objectForKey:@"event_description"] isEqual:[NSNull null]] && ![[dictionary objectForKey:@"event_description"] isEqualToString:@""])
        {
            self.details = [dictionary objectForKey:@"event_description"];
        }
        if(![[dictionary objectForKey:@"music"] isEqual:[NSNull null]])
        {
            self.music = [[NSMutableArray alloc] init];
            NSArray *music = [dictionary objectForKey:@"audio"];
            for(NSDictionary *songDictionary in music)
            {
                [self.music addObject:songDictionary];
            }
        }
        if(![[dictionary objectForKey:@"event_id"] isEqual:[NSNull null]])
        {
            self.eventID = [[dictionary objectForKey:@"event_id"] integerValue];
        }
        if(![[dictionary objectForKey:@"poster_image_url"] isEqual:[NSNull null]])
        {
            NSString *posterImageUrl = [dictionary objectForKey:@"poster_image_url"];
            if(posterImageUrl != nil && ![posterImageUrl isEqualToString:@""])
            {
                self.posterImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASEURL, posterImageUrl]]]];
            }
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
