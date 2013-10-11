//
//  ScannerViewController.h
//  HackVtProject
//
//  Created by Jordan Rouille on 10/10/13.
//  Copyright (c) 2013 CSScrew. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <ZBarSDK/ZBarSDK.h>

@interface ScannerViewController : ZBarReaderViewController <CLLocationManagerDelegate, UIImagePickerControllerDelegate, ZBarReaderDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
//@property (strong, nonatomic) ZBarReaderViewController *reader;

@end
