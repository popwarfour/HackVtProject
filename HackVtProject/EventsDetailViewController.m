//
//  EventsDetailViewController.m
//  HackVtProject
//
//  Created by Jordan Rouille on 10/11/13.
//  Copyright (c) 2013 CSScrew. All rights reserved.
//

#import "EventsDetailViewController.h"
#import "UIColor+methods.h"
#import "UIFont+methods.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

@interface EventsDetailViewController ()

@end

@implementation EventsDetailViewController

-(id)initWithEventObject:(EventObject *)eventObject
{
    if([UIScreen mainScreen].bounds.size.height == 568.0)
    {
        self = [super initWithNibName:@"EventsDetailViewController" bundle:nil];
    }
    else
    {
        self = [super initWithNibName:@"EventsDetailViewController_Small" bundle:nil];
    }
    
    if (self)
    {
        self.eventObject = eventObject;
        
        self.mainNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        [self.view addSubview:self.mainNavBar];
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [backButton setImage:[UIImage imageNamed:@"Back.png"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(5, 5, 60, 34)];
        [self.mainNavBar addSubview:backButton];
        
        int contentHeight = 5;
        
        self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 44)];
        
        if(eventObject.title != nil)
        {
            self.eventTitle = [[UILabel alloc] initWithFrame:CGRectMake(65, contentHeight, self.view.frame.size.width - 70, 34)];
            [self.eventTitle setNumberOfLines:2];
            [self.eventTitle setFont:[UIFont eventsDetailTitle]];
            [self.eventTitle setText:eventObject.title];
            [self.eventTitle setBackgroundColor:[UIColor clearColor]];
            [self.eventTitle setTextAlignment:NSTextAlignmentCenter];
            [self.mainNavBar addSubview:self.eventTitle];
        }
        
        BOOL largeView = FALSE;
        //if(eventObject.posterImage != nil && (eventObject.eventDate != nil || eventObject.location != nil || eventObject.city || eventObject.genre != nil))
        if(eventObject.posterImage != nil)
        {
            largeView = TRUE;
            //Small Poster Image
            
      
            self.posterImage = [[UIImageView alloc] initWithImage:eventObject.posterImage];
            [self.posterImage setFrame:CGRectMake(5, contentHeight, 130, 180)];
            [self.mainScrollView addSubview:self.posterImage];
        
            /*
            UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [likeButton setImage:[UIImage imageNamed:@"like.jpg"] forState:UIControlStateNormal];
            [likeButton setFrame:CGRectMake(self.posterImage.frame.origin.x + self.posterImage.frame.size.width + 5, contentHeight, 50, 50)];
            //[likeButton addTarget:self action:@selector(likeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
            [self.mainScrollView addSubview:likeButton];
            
            UIButton *calButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [calButton setImage:[UIImage imageNamed:@"addCalander.png"] forState:UIControlStateNormal];
            [calButton setFrame:CGRectMake(self.mainScrollView.frame.size.width - 55, contentHeight, 50, 50)];
            //[calButton addTarget:self action:@selector(calButtonPressed) forControlEvents:UIControlEventTouchUpInside];
            [self.mainScrollView addSubview:calButton];
            //contentHeight += 55;
            */
            
            if(eventObject.eventDate != nil)
            {
                UILabel *eventTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.posterImage.frame.size.width + 10, contentHeight, self.mainScrollView.frame.size.width - (self.posterImage.frame.size.width + 20), 20)];
                [eventTitle setBackgroundColor:[UIColor clearColor]];
                [eventTitle setFont:[UIFont eventsDetailTitle]];
                [eventTitle setTextColor:[UIColor eventDateColor]];
                [eventTitle setText:@"Event Date"];
                [eventTitle setTextAlignment:NSTextAlignmentCenter];
                [self.mainScrollView addSubview:eventTitle];
                
                contentHeight += 25;
                
                UILabel *eventDate = [[UILabel alloc] initWithFrame:CGRectMake(self.posterImage.frame.size.width + 10, contentHeight, self.mainScrollView.frame.size.width - (self.posterImage.frame.size.width + 20), 20)];
                [eventDate setFont:[UIFont eventsDetailsMemebers]];
                /*
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"EEE MMM dd yyyy"];
                [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
                NSString *formattedDate = [dateFormatter stringFromDate:eventObject.eventDate];
                 */
                [eventDate setText:eventObject.eventDate];
                [eventDate setTextAlignment:NSTextAlignmentCenter];
                [eventDate setBackgroundColor:[UIColor clearColor]];
                [self.mainScrollView addSubview:eventDate];
                
                contentHeight += 20 + 5;
            }
            
            if(eventObject.location != nil)
            {
                UILabel *eventTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.posterImage.frame.size.width + 10, contentHeight, self.mainScrollView.frame.size.width - (self.posterImage.frame.size.width + 20), 20)];
                [eventTitle setBackgroundColor:[UIColor clearColor]];
                [eventTitle setFont:[UIFont eventsDetailTitle]];
                [eventTitle setText:@"Venue"];
                [eventTitle setTextColor:[UIColor eventVenueColor]];
                [eventTitle setTextAlignment:NSTextAlignmentCenter];
                [self.mainScrollView addSubview:eventTitle];
                
                contentHeight += 25;
                
                UILabel *eventDate = [[UILabel alloc] initWithFrame:CGRectMake(self.posterImage.frame.size.width + 10, contentHeight, self.mainScrollView.frame.size.width - (self.posterImage.frame.size.width + 20), 20)];
                [eventDate setFont:[UIFont eventsDetailsMemebers]];
                [eventDate setText:eventObject.location];
                [eventDate setBackgroundColor:[UIColor clearColor]];
                [eventDate setTextAlignment:NSTextAlignmentCenter];
                [self.mainScrollView addSubview:eventDate];
                
                contentHeight += 20 + 5;
            }
            
            if(eventObject.city != nil)
            {
                UILabel *eventTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.posterImage.frame.size.width + 10, contentHeight, self.mainScrollView.frame.size.width - (self.posterImage.frame.size.width + 20), 20)];
                [eventTitle setBackgroundColor:[UIColor clearColor]];
                [eventTitle setFont:[UIFont eventsDetailTitle]];
                [eventTitle setText:@"Location"];
                [eventTitle setTextColor:[UIColor eventLocationColor]];
                [eventTitle setTextAlignment:NSTextAlignmentCenter];
                [self.mainScrollView addSubview:eventTitle];
                
                contentHeight += 25;
                
                UILabel *eventDate = [[UILabel alloc] initWithFrame:CGRectMake(self.posterImage.frame.size.width + 10, contentHeight, self.mainScrollView.frame.size.width - (self.posterImage.frame.size.width + 20), 20)];
                [eventDate setFont:[UIFont eventsDetailsMemebers]];
                [eventDate setText:eventObject.city];
                [eventDate setTextAlignment:NSTextAlignmentCenter];
                [eventDate setBackgroundColor:[UIColor clearColor]];
                [self.mainScrollView addSubview:eventDate];
                
                contentHeight += 20 + 5;
            }
            
            if(eventObject.genre != nil && ![eventObject.genre isEqualToString:@""])
            {
                UILabel *eventTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.posterImage.frame.size.width + 10, contentHeight, self.mainScrollView.frame.size.width - (self.posterImage.frame.size.width + 20), 20)];
                [eventTitle setBackgroundColor:[UIColor clearColor]];
                [eventTitle setFont:[UIFont eventsDetailTitle]];
                [eventTitle setText:@"Genre"];
                [eventTitle setTextColor:[UIColor eventGenreColor]];
                [eventTitle setTextAlignment:NSTextAlignmentCenter];
                [self.mainScrollView addSubview:eventTitle];
                
                contentHeight += 25;
                
                UILabel *eventDate = [[UILabel alloc] initWithFrame:CGRectMake(self.posterImage.frame.size.width + 10, contentHeight, self.mainScrollView.frame.size.width - (self.posterImage.frame.size.width + 20), 20)];
                [eventDate setFont:[UIFont eventsDetailsMemebers]];
                [eventDate setText:eventObject.genre];
                [eventDate setTextAlignment:NSTextAlignmentCenter];
                [eventDate setBackgroundColor:[UIColor clearColor]];
                [self.mainScrollView addSubview:eventDate];
                
                contentHeight += 20 + 5;
            }
            
            /*
            if(eventObject.memebers != nil)
            {
                if(eventObject.memebers.count > 0)
                {
                    UILabel *artistsLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.posterImage.frame.size.width + 10, contentHeight, self.view.frame.size.width - (self.posterImage.frame.size.width + 20), 20)];
                    [artistsLabel setText:@"Artists"];
                    [artistsLabel setBackgroundColor:[UIColor clearColor]];
                    [artistsLabel setFont:[UIFont eventsDetailTitle]];
                    [artistsLabel setTextAlignment:NSTextAlignmentLeft];
                    [self.mainScrollView addSubview:artistsLabel];
                    
                    contentHeight += 25;
                    
                    UILabel *memebers = [[UILabel alloc] initWithFrame:CGRectMake(self.posterImage.frame.size.width + 10, contentHeight, self.mainScrollView.frame.size.width - (self.posterImage.frame.size.width + 20), 20)];
                    NSMutableString *memebersString = [[NSMutableString alloc] init];
                    [memebers setNumberOfLines:0];
                    for(int i = 0; i < eventObject.memebers.count; i++)
                    {
                        if(i == 0)
                        {
                            [memebersString appendString:[eventObject.memebers objectAtIndex:i]];
                        }
                        else
                        {
                            [memebersString appendString:[NSString stringWithFormat:@", %@", [eventObject.memebers objectAtIndex:i]]];
                        }
                    }
                    [memebers setFont:[UIFont eventsDetailsMemebers]];
                    CGSize size = [memebersString sizeWithFont:[UIFont eventsDetailsMemebers] constrainedToSize:CGSizeMake(memebers.frame.size.width, CGFLOAT_MAX)];
                    [memebers setText:memebersString];
                    [memebers setTextAlignment:NSTextAlignmentLeft];
                    [memebers setBackgroundColor:[UIColor clearColor]];
                    [memebers setFrame:CGRectMake(memebers.frame.origin.x, memebers.frame.origin.y, memebers.frame.size.width, size.height)];
                    
                    [self.mainScrollView addSubview:memebers];
                    
                    contentHeight += memebers.frame.size.height + 5;
                }
            }*/
        }
        else
        {
            /*
            UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [likeButton setImage:[UIImage imageNamed:@"like.jpg"] forState:UIControlStateNormal];
            [likeButton setFrame:CGRectMake(5, contentHeight, 50, 50)];
            //[likeButton addTarget:self action:@selector(likeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
            [self.mainScrollView addSubview:likeButton];
            
            UIButton *calButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [calButton setImage:[UIImage imageNamed:@"addCalander.png"] forState:UIControlStateNormal];
            [calButton setFrame:CGRectMake(self.mainScrollView.frame.size.width - 55, contentHeight, 50, 50)];
            //[calButton addTarget:self action:@selector(calButtonPressed) forControlEvents:UIControlEventTouchUpInside];
            [self.mainScrollView addSubview:calButton];
            //contentHeight += 55;
            */
            
            if(eventObject.eventDate != nil)
            {
                UILabel *eventTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, contentHeight, self.mainScrollView.frame.size.width - 10, 20)];
                [eventTitle setBackgroundColor:[UIColor clearColor]];
                [eventTitle setFont:[UIFont eventsDetailTitle]];
                [eventTitle setTextColor:[UIColor eventDateColor]];
                [eventTitle setText:@"Event Date"];
                [eventTitle setTextAlignment:NSTextAlignmentCenter];
                [self.mainScrollView addSubview:eventTitle];
                
                contentHeight += 25;
                
                UILabel *eventDate = [[UILabel alloc] initWithFrame:CGRectMake(5, contentHeight, self.mainScrollView.frame.size.width - 10, 20)];
                [eventDate setFont:[UIFont eventsDetailsMemebers]];
                /*
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"EEE MMM dd yyyy"];
                [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
                NSString *formattedDate = [dateFormatter stringFromDate:eventObject.eventDate];
                 */
                [eventDate setText:eventObject.eventDate];
                [eventDate setTextAlignment:NSTextAlignmentCenter];
                [eventDate setBackgroundColor:[UIColor clearColor]];
                [self.mainScrollView addSubview:eventDate];
                
                contentHeight += 20 + 5;
            }
            
            if(eventObject.location != nil)
            {
                UILabel *eventTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, contentHeight, self.mainScrollView.frame.size.width - 10, 20)];
                [eventTitle setBackgroundColor:[UIColor clearColor]];
                [eventTitle setFont:[UIFont eventsDetailTitle]];
                [eventTitle setText:@"Venue"];
                [eventTitle setTextColor:[UIColor eventVenueColor]];
                [eventTitle setTextAlignment:NSTextAlignmentCenter];
                [self.mainScrollView addSubview:eventTitle];
                
                contentHeight += 25;
                
                UILabel *eventDate = [[UILabel alloc] initWithFrame:CGRectMake(5, contentHeight, self.mainScrollView.frame.size.width - 10, 20)];
                [eventDate setFont:[UIFont eventsDetailsMemebers]];
                [eventDate setText:eventObject.location];
                [eventDate setBackgroundColor:[UIColor clearColor]];
                [eventDate setTextAlignment:NSTextAlignmentCenter];
                [self.mainScrollView addSubview:eventDate];
                
                contentHeight += 20 + 5;
            }
            
            if(eventObject.city != nil)
            {
                UILabel *eventTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, contentHeight, self.mainScrollView.frame.size.width - 10, 20)];
                [eventTitle setBackgroundColor:[UIColor clearColor]];
                [eventTitle setFont:[UIFont eventsDetailTitle]];
                [eventTitle setText:@"Location"];
                [eventTitle setTextColor:[UIColor eventLocationColor]];
                [eventTitle setTextAlignment:NSTextAlignmentCenter];
                [self.mainScrollView addSubview:eventTitle];
                
                contentHeight += 25;
                
                UILabel *eventDate = [[UILabel alloc] initWithFrame:CGRectMake(5, contentHeight, self.mainScrollView.frame.size.width - 10, 20)];
                [eventDate setFont:[UIFont eventsDetailsMemebers]];
                [eventDate setText:eventObject.city];
                [eventDate setTextAlignment:NSTextAlignmentCenter];
                [eventDate setBackgroundColor:[UIColor clearColor]];
                [self.mainScrollView addSubview:eventDate];
                
                contentHeight += 20 + 5;
            }
            
            if(eventObject.genre != nil && ![eventObject.genre isEqualToString:@""])
            {
                UILabel *eventTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, contentHeight, self.mainScrollView.frame.size.width - 10, 20)];
                [eventTitle setBackgroundColor:[UIColor clearColor]];
                [eventTitle setFont:[UIFont eventsDetailTitle]];
                [eventTitle setText:@"Genre"];
                [eventTitle setTextColor:[UIColor eventGenreColor]];
                [eventTitle setTextAlignment:NSTextAlignmentCenter];
                [self.mainScrollView addSubview:eventTitle];
                
                contentHeight += 25;
                
                UILabel *eventDate = [[UILabel alloc] initWithFrame:CGRectMake(5, contentHeight, self.mainScrollView.frame.size.width - 10, 20)];
                [eventDate setFont:[UIFont eventsDetailsMemebers]];
                [eventDate setText:eventObject.genre];
                [eventDate setTextAlignment:NSTextAlignmentCenter];
                [eventDate setBackgroundColor:[UIColor clearColor]];
                [self.mainScrollView addSubview:eventDate];
                
                contentHeight += 20 + 5;
            }
            /*
            //Large Poster Image
            if(eventObject.posterImage != nil)
            {
                self.posterImage = [[UIImageView alloc] initWithImage:eventObject.posterImage];
                [self.posterImage setFrame:CGRectMake(40, contentHeight, 240, 350)];
                [self.mainScrollView addSubview:self.posterImage];
                
                self.posterImage = [[UIImageView alloc] initWithImage:eventObject.posterImage];
                [self.posterImage setFrame:CGRectMake(5, contentHeight, 130, 180)];
                [self.mainScrollView addSubview:self.posterImage];
                
                contentHeight += 355;
            }
            
            if(eventObject.eventDate != nil)
            {
                UILabel *eventTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, contentHeight, self.mainScrollView.frame.size.width - 10, 20)];
                [eventTitle setBackgroundColor:[UIColor clearColor]];
                [eventTitle setFont:[UIFont eventsDetailTitle]];
                [eventTitle setText:@"Event Date"];
                [self.mainScrollView addSubview:eventTitle];
                
                contentHeight += 25;
                
                UILabel *eventDate = [[UILabel alloc] initWithFrame:CGRectMake(5, contentHeight, self.mainScrollView.frame.size.width - 10, 20)];
                [eventDate setFont:[UIFont eventsDetailsMemebers]];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"EEE MMM dd yyyy"];
                [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
                NSString *formattedDate = [dateFormatter stringFromDate:eventObject.eventDate];
                [eventDate setText:formattedDate];
                [eventDate setBackgroundColor:[UIColor clearColor]];
                [self.mainScrollView addSubview:eventDate];
                
                contentHeight += 20 + 5;
            }
            */
            /*
            if(eventObject.memebers != nil)
            {
                if(eventObject.memebers.count > 0)
                {
                    UILabel *artistsLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, contentHeight, self.view.frame.size.width - 10, 20)];
                    [artistsLabel setText:@"Artists"];
                    [artistsLabel setBackgroundColor:[UIColor clearColor]];
                    [artistsLabel setFont:[UIFont eventsDetailTitle]];
                    [artistsLabel setTextAlignment:NSTextAlignmentLeft];
                    [self.mainScrollView addSubview:artistsLabel];
                    
                    contentHeight += 25;
                    
                    UILabel *memebers = [[UILabel alloc] initWithFrame:CGRectMake(5, contentHeight, self.mainScrollView.frame.size.width - 10, 20)];
                    NSMutableString *memebersString = [[NSMutableString alloc] init];
                    [memebers setNumberOfLines:0];
                    for(int i = 0; i < eventObject.memebers.count; i++)
                    {
                        if(i == 0)
                        {
                            [memebersString appendString:[eventObject.memebers objectAtIndex:i]];
                        }
                        else
                        {
                            [memebersString appendString:[NSString stringWithFormat:@", %@", [eventObject.memebers objectAtIndex:i]]];
                        }
                    }
                    [memebers setFont:[UIFont eventsDetailsMemebers]];
                    CGSize size = [memebersString sizeWithFont:[UIFont eventsDetailsMemebers] constrainedToSize:CGSizeMake(memebers.frame.size.width, CGFLOAT_MAX)];
                    [memebers setText:memebersString];
                    [memebers setTextAlignment:NSTextAlignmentLeft];
                    [memebers setBackgroundColor:[UIColor clearColor]];
                    [memebers setFrame:CGRectMake(memebers.frame.origin.x, memebers.frame.origin.y, memebers.frame.size.width, size.height)];
                    
                    [self.mainScrollView addSubview:memebers];
                    
                    contentHeight += memebers.frame.size.height + 5;
                }
            }
             */
        }
        
        
        
        if(eventObject.details != nil)
        {
            NSLog(@"%f", self.posterImage.frame.origin.y + self.posterImage.frame.size.height);
            if(largeView && contentHeight < self.posterImage.frame.origin.y + self.posterImage.frame.size.height)
            {
                contentHeight = self.posterImage.frame.origin.y + self.posterImage.frame.size.height + 5;
            }
            UILabel *descriptionTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, contentHeight, self.view.frame.size.width - 10, 20)];
            [descriptionTitle setText:@"Event Description"];
            [descriptionTitle setBackgroundColor:[UIColor clearColor]];
            [descriptionTitle setTextColor:[UIColor eventDescriptionColor]];
            [descriptionTitle setFont:[UIFont eventsDetailTitle]];
            [descriptionTitle setTextAlignment:NSTextAlignmentCenter];
            [self.mainScrollView addSubview:descriptionTitle];
            
            contentHeight += 25;
            
            CGSize size = [eventObject.details sizeWithFont:[UIFont eventsDetailDetails] constrainedToSize:CGSizeMake(self.view.frame.size.width - 20, CGFLOAT_MAX)];
            
            UILabel *eventDetails = nil;
            eventDetails = [[UILabel alloc] initWithFrame:CGRectMake(5, contentHeight, self.mainScrollView.frame.size.width - 10, size.height)];
            
            [eventDetails setTextAlignment:NSTextAlignmentCenter];
            [eventDetails setFont:[UIFont eventsDetailDetails]];
            [eventDetails setText:eventObject.details];
            [eventDetails setNumberOfLines:0];
            
            [eventDetails setBackgroundColor:[UIColor clearColor]];
            [self.mainScrollView addSubview:eventDetails];
            
            contentHeight += size.height + 5;
        }
        
        if(eventObject.music != nil)
        {
            if(eventObject.music.count > 0)
            {
                contentHeight += 8;
                
                if(self.posterImage.image != nil)
                {
                    if(contentHeight < self.posterImage.frame.origin.y + self.posterImage.frame.size.height)
                    {
                        contentHeight = self.posterImage.frame.origin.y + self.posterImage.frame.size.height + 10;
                    }
                }
                
                UIView *musicBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(5, contentHeight - 8, self.mainScrollView.frame.size.width - 10, 10)];
                [musicBackgroundView.layer setCornerRadius:15];
                [musicBackgroundView setBackgroundColor:[UIColor grayColor]];
                [self.mainScrollView addSubview:musicBackgroundView];
                
                int counter = 0;
                for(NSDictionary *music in eventObject.music)
                {
                    NSString *songTitle = [music objectForKey:@"audio_title"];
                    
                    UIButton *music = [UIButton buttonWithType:UIButtonTypeCustom];
                    music.tag = counter;
                    [music setImage:[UIImage imageNamed:@"musicNote.png"] forState:UIControlStateNormal];
                    [music addTarget:self action:@selector(playMusic:) forControlEvents:UIControlEventTouchUpInside];
                    [music setFrame:CGRectMake(15, contentHeight - 3, 30, 30)];
                    
                    UILabel *songLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + 35, contentHeight + 3, self.view.frame.size.width - 60 - 20, 20)];
                    [songLabel setText:songTitle];
                    [songLabel setBackgroundColor:[UIColor clearColor]];
                    [songLabel setTextAlignment:NSTextAlignmentLeft];
                    
                    
                    [self.mainScrollView addSubview:music];
                    [self.mainScrollView addSubview:songLabel];
                    
       
                    counter++;
                    contentHeight += 35;
                    
                    if(counter != eventObject.music.count)
                    {
                        UIView *seprator = [[UIView alloc] initWithFrame:CGRectMake(5, contentHeight - 5, self.mainScrollView.frame.size.width - 10, 1)];
                        [seprator setBackgroundColor:[UIColor blackColor]];
                        [self.mainScrollView addSubview:seprator];
                    }
                }
                
                [musicBackgroundView setFrame:CGRectMake(musicBackgroundView.frame.origin.x, musicBackgroundView.frame.origin.y, musicBackgroundView.frame.size.width, (counter * 35) + 5)];
                
            }
        }

        [self.mainScrollView setContentSize:CGSizeMake(self.view.frame.size.width, contentHeight)];
        [self.view addSubview:self.mainScrollView];
    }
    return self;
}

-(IBAction)playMusic:(UIButton *)sender
{
    int indexOfSong = sender.tag;
    NSString *urlString = [[self.eventObject.music objectAtIndex:indexOfSong] objectForKey:@"audio_url"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

-(void)backButtonPressed
{
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

-(void)likeButtonPressed
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Event Followed"] message:[NSString stringWithFormat:@"%@ will now be added to your list of suggested events"] delegate:self cancelButtonTitle:@"close" otherButtonTitles:nil, nil];
    [alert show];
}
-(void)calButtonPressed
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"You Are Now Attending"] message:[NSString stringWithFormat:@"%@ will now be added to your calander and list of suggested events"] delegate:self cancelButtonTitle:@"close" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)viewWillAppear:(BOOL)animated
{
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
