//
//  EventCell.h
//  HackVtProject
//
//  Created by Jordan Rouille on 10/11/13.
//  Copyright (c) 2013 CSScrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventObject.h"
#import "UIFont+methods.h"
#import "UIColor+methods.h"

@interface EventCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andEventObject:(EventObject *)eventObject;

@end
