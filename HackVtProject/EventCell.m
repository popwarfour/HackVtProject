//
//  EventCell.m
//  HackVtProject
//
//  Created by Jordan Rouille on 10/11/13.
//  Copyright (c) 2013 CSScrew. All rights reserved.
//

#import "EventCell.h"
#import "EventObject.h"

@implementation EventCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andEventObject:(EventObject *)eventObject
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UILabel *eventTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width - 10, 30)];
        [eventTitle setText:eventObject.title];
        [self.contentView addSubview:eventTitle];
        
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imageName.png"]];
        [image setFrame:CGRectMake(5, 5, 10, 10)];
        [self.contentView addSubview:image];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
