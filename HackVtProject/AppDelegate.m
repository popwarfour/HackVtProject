//
//  AppDelegate.m
//  HackVtProject
//
//  Created by Jordan Rouille on 10/10/13.
//  Copyright (c) 2013 CSScrew. All rights reserved.
//

#import "AppDelegate.h"
#import <ZBarSDK/zbar.h>


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    //if (YES)
    {
        [[NSUserDefaults standardUserDefaults] setObject: @YES forKey: @"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSString *uniqueID = CFBridgingRelease(CFUUIDCreate(NULL));
        [[NSUserDefaults standardUserDefaults] setObject:uniqueID forKey: @"UserID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    //First Call of singleton container controller will allocate and initilize it
    ContainerController *mainContainerController = [ContainerController sharedContainer];
    
    EventsViewController *theEventsController = nil;
    ScannerViewController *theScannerController = nil;
    
    if([UIScreen mainScreen].bounds.size.height == 568.0)
    {
        theEventsController = [[EventsViewController alloc] initWithNibName:@"EventsViewController" bundle:nil];
        theScannerController = [[ScannerViewController alloc] initWithNibName:@"ScannerViewController" bundle:nil];
    }
    else
    {
        theEventsController = [[EventsViewController alloc] initWithNibName:@"EventsViewController_Small" bundle:nil];
        theScannerController = [[ScannerViewController alloc] initWithNibName:@"ScannerViewController_Small" bundle:nil];
    }
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    /*
    //Title To Appear On TabBar
    theEventsController.title = @"Events";
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:theEventsController.title image:[UIImage new] tag:0];
    [theEventsController setTabBarItem:item];
    
    //Title To Appear On TabBar
    theScannerController.title = @"Scan QR";
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:theScannerController.title image:[UIImage new] tag:0];
    [theScannerController setTabBarItem:item2];
    */
    //[mainContainerController setViewControllers:[NSArray arrayWithObjects:theEventsController, theScannerController, nil] animated:TRUE];
    self.window.rootViewController = theEventsController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
