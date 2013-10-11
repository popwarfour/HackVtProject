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


-(id)initWithJSONObject:(NSDictionary *)dictionary;

@end
