//
//  EventsViewController.h
//  HackVtProject
//
//  Created by Jordan Rouille on 10/10/13.
//  Copyright (c) 2013 CSScrew. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <ZBarSDK/ZBarSDK.h>

@interface EventsViewController : UIViewController <ZBarReaderDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) ZBarReaderViewController *reader;

@end
