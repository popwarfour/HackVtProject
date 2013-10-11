//
//  ContainerController.h
//  HackVtProject
//
//  Created by Jordan Rouille on 10/10/13.
//  Copyright (c) 2013 CSScrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventsViewController.h"
#import "ScannerViewController.h"

@interface ContainerController : UITabBarController

+(ContainerController *)sharedContainer;

@property (nonatomic, strong) EventsViewController *theEventsController;
@property (nonatomic, strong) ScannerViewController *theScannerController;

@end
