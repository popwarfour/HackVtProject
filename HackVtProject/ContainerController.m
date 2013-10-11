//
//  ContainerController.m
//  HackVtProject
//
//  Created by Jordan Rouille on 10/10/13.
//  Copyright (c) 2013 CSScrew. All rights reserved.
//

#import "ContainerController.h"

@interface ContainerController ()

@end

@implementation ContainerController

static ContainerController* theContainerView = nil;

#pragma mark - Singlton Initilizer

+(ContainerController *)sharedContainer
{
    @synchronized([theContainerView class])
    {
        if (theContainerView == nil)
        {
            //Initilize For the First Time!
            theContainerView = [[self alloc] init];
        }
        
        return theContainerView;
    }
    return nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
