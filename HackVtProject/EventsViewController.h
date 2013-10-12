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
#import "CSocketController.h"

@interface EventsViewController : UIViewController <ZBarReaderDelegate, UIImagePickerControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) ZBarReaderViewController *reader;
@property (weak, nonatomic) IBOutlet UITableView *eventsTableView;

@property (nonatomic, strong) UISegmentedControl *eventsSegment;
@property (nonatomic, strong) UIButton *QRScanButton;

@property (nonatomic, strong) NSMutableArray *allEvents;
@property (nonatomic, strong) NSMutableArray *suggestedEvents;
@property (nonatomic, strong) NSMutableArray *scannedEvents;

@property (nonatomic, strong) UIView *segmentBackgroundView;

@end
