//
//  CSocketController.h
//  GoGreen
//
//  Created by Jordan Rouille on 8/31/13.
//  Copyright (c) 2013 Aidan Melen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSocketController : NSObject

+(CSocketController*)sharedCSocketController;

//GET
-(id)performGETRequestToHost:(NSString *)host withRelativeURL:(NSString *)relativeURL andIP:(NSString *)ipString withPort:(int)port withProperties:(NSDictionary *)properties;

//PUT
-(id)performPUTRequestToHost:(NSString *)host withRelativeURL:(NSString *)relativeURL andIP:(NSString *)ipString withPort:(int)port withProperties:(id)properties;

//POST
-(id)performPOSTRequestToHost:(NSString *)host withRelativeURL:(NSString *)relativeURL andIP:(NSString *)ipString withPort:(int)port withProperties:(NSDictionary *)properties;
@end
