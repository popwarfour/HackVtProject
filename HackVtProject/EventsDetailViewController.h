//
//  EventsDetailViewController.h
//  HackVtProject
//
//  Created by Jordan Rouille on 10/11/13.
//  Copyright (c) 2013 CSScrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventObject.h"

@interface EventsDetailViewController : UIViewController

-(id)initWithEventObject:(EventObject *)eventObject;

@property (nonatomic, strong) UINavigationBar *mainNavBar;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UILabel *eventDate;
@property (nonatomic, strong) UILabel *eventTitle;
@property (nonatomic, strong) UILabel *memebersString;
@property (nonatomic, strong) UIImageView *posterImage;
@property (nonatomic, strong) UITextView *details;

@end
