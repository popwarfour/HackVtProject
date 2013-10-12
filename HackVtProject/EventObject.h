//
//  EventObject.h
//  HackVtProject
//
//  Created by Jordan Rouille on 10/11/13.
//  Copyright (c) 2013 CSScrew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventObject : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSDate *eventDate;
@property (nonatomic, strong) NSMutableArray *memebers;
@property (nonatomic, strong) UIImage *posterImage;
@property (nonatomic, strong) NSString *details;
@property (nonatomic, strong) NSMutableArray *music;
@property int eventID;

-(id)initWithJSONObject:(NSDictionary *)dictionary;

@end
