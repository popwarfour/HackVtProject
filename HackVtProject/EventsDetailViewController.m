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
                NSString *memebersString = @"";
                [memebers setNumberOfLines:0];
                for(int i = 0; eventObject.memebers.count; i++)
                {
                    if(i == eventObject.memebers.count - 1)
                    {
                        memebersString = [NSString stringWithFormat:@"%@", [eventObject.memebers objectAtIndex:i]];
                    }
                    else
                    {
                        memebersString = [NSString stringWithFormat:@"%@, %@", memebersString, [eventObject.memebers objectAtIndex:i]];
                    }
                }
                [memebers setText:memebersString];
                [memebers setBackgroundColor:[UIColor clearColor]];
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

        [self.mainScrollView setContentSize:CGSizeMake(self.view.frame.size.width, contentHeight)];
        [self.view addSubview:self.mainScrollView];
    }
    return self;
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
