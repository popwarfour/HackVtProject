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

@interface EventsDetailViewController ()

@end

@implementation EventsDetailViewController

-(id)initWithEventObject:(EventObject *)eventObject
{
    self = [super initWithNibName:@"EventsDetailViewController" bundle:nil];
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
        
        if(eventObject.posterImage != nil)
        {
            self.posterImage = [[UIImageView alloc] initWithImage:eventObject.posterImage];
            [self.posterImage setFrame:CGRectMake(40, contentHeight, 240, 350)];
            [self.mainScrollView addSubview:self.posterImage];
            
            contentHeight += 355;
        }
        
        if(eventObject.eventDate != nil)
        {
            UILabel *eventDate = [[UILabel alloc] initWithFrame:CGRectMake(5, contentHeight, self.mainScrollView.frame.size.width - 10, 20)];
            [eventDate setFont:[UIFont eventsDetailTitle]];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"EEE MMM dd yyyy"];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
            NSString *formattedDate = [dateFormatter stringFromDate:eventObject.eventDate];
            [eventDate setText:[NSString stringWithFormat:@"Event Date: %@",formattedDate]];
            [eventDate setBackgroundColor:[UIColor clearColor]];
            [self.mainScrollView addSubview:eventDate];
            
            contentHeight += 20 + 5;
        }
        
        if(eventObject.memebers != nil)
        {
            if(eventObject.memebers.count > 0)
            {
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
                [memebers setBackgroundColor:[UIColor clearColor]];
                [memebers setFrame:CGRectMake(memebers.frame.origin.x, memebers.frame.origin.y, memebers.frame.size.width, size.height)];
                
                [self.mainScrollView addSubview:memebers];
                
                contentHeight += memebers.frame.size.height + 5;
            }
        }
        
        if(eventObject.details != nil)
        {
            CGSize size = [eventObject.details sizeWithFont:[UIFont eventsCellDescription] constrainedToSize:CGSizeMake(self.view.frame.size.width - 20, CGFLOAT_MAX)];
            
            UILabel *eventDetails = nil;
            eventDetails = [[UILabel alloc] initWithFrame:CGRectMake(5, contentHeight, self.mainScrollView.frame.size.width - 10, size.height)];
            
            [eventDetails setTextAlignment:NSTextAlignmentLeft];
            [eventDetails setFont:[UIFont eventsCellDescription]];
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
                for(NSDictionary *music in eventObject.music)
                {
                    NSString *songTitle = [music objectForKey:@"title"];
                    
                    UIButton *music = [UIButton buttonWithType:UIButtonTypeCustom];
                    music.tag = [eventObject.music indexOfObject:music];
                    [music setImage:[UIImage imageNamed:@"musicNote.png"] forState:UIControlStateNormal];
                    [music addTarget:self action:@selector(playMusic:) forControlEvents:UIControlEventTouchUpInside];
                    [music setFrame:CGRectMake(10, contentHeight, 50, 50)];
                    
                    UILabel *songLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + 55, contentHeight, self.view.frame.size.width - 60 - 15, 50)];
                    [songLabel setText:songTitle];
                    [songLabel setBackgroundColor:[UIColor clearColor]];
                    [songLabel setTextAlignment:NSTextAlignmentLeft];
                    
                    
                    [self.mainScrollView addSubview:music];
                    [self.mainScrollView addSubview:songLabel];
                    
                    contentHeight += 55;
                }
                
                
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
    NSString *urlString = [[self.eventObject.music objectAtIndex:indexOfSong] objectForKey:@"url"];
    
    NSURL *url = [NSURL URLWithString:urlString];
                  
    // You may find a test stream at <http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8>.

    self.playerItem = [AVPlayerItem playerItemWithURL:url];

    //(optional) [playerItem addObserver:self forKeyPath:@"status" options:0 context:&ItemStatusContext];

    self.player = [AVPlayer playerWithPlayerItem:playerItem];

    self.player = [AVPlayer playerWithURL:￼];

    //(optional) [player addObserver:self forKeyPath:@"status" options:0 context:&PlayerStatusContext];
}

-(void)backButtonPressed
{
    [self dismissViewControllerAnimated:TRUE completion:nil];
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
