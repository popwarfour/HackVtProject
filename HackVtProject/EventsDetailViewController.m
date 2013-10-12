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
            self.eventTitle = [[UILabel alloc] initWithFrame:CGRectMake(70, contentHeight, self.view.frame.size.width - 75, 34)];
            [self.eventTitle setNumberOfLines:2];
            [self.eventTitle setFont:[UIFont eventsDetailTitle]];
            [self.eventTitle setText:eventObject.title];
            [self.eventTitle setTextAlignment:NSTextAlignmentCenter];
            [self.mainNavBar addSubview:self.eventTitle];
            
            contentHeight += 30;
        }
        
        if(eventObject.posterImage != nil)
        {
            self.posterImage = [[UIImageView alloc] initWithImage:eventObject.posterImage];
            [self.posterImage setFrame:CGRectMake(40, contentHeight, 240, 350)];
            [self.mainScrollView addSubview:self.posterImage];
            
            contentHeight += 350;
        }
        
        [self.mainScrollView setContentSize:CGSizeMake(self.view.frame.size.width, contentHeight + 5)];
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
