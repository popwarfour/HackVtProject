//
//  EventCell.m
//  HackVtProject
//
//  Created by Jordan Rouille on 10/11/13.
//  Copyright (c) 2013 CSScrew. All rights reserved.
//

#import "EventCell.h"
#import "EventObject.h"
#import <QuartzCore/QuartzCore.h>

@implementation EventCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andEventObject:(EventObject *)eventObject
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, self.contentView.frame.size.width - 10, 100)];
        [backgroundView.layer setCornerRadius:10];
        [backgroundView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tableViewCellBackground.png"]]];
        [backgroundView.layer setBorderWidth:1];
        [backgroundView.layer setBorderColor:[UIColor blackColor].CGColor];
        [self.contentView addSubview:backgroundView];
        
        int height = 5;
        int leftPadding = 5;
        
        if(eventObject.posterImage != nil)
        {
            UIImageView *image = [[UIImageView alloc] initWithImage:eventObject.posterImage];
            [image setFrame:CGRectMake(10, leftPadding, 60, 90)];
            [self.contentView addSubview:image];
            
            leftPadding += 70;
        }
        else
        {
            UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"speak.png"]];
            [image setFrame:CGRectMake(10, leftPadding + 15, 60, 60)];
            [self.contentView addSubview:image];
            
            leftPadding += 70;
        }
        if(eventObject.title != nil)
        {
            UILabel *eventTitle = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, height, self.frame.size.width - leftPadding - 10, 20)];
            [eventTitle setTextAlignment:NSTextAlignmentLeft];
            [eventTitle setFont:[UIFont eventsCellTitle]];
            [eventTitle setText:eventObject.title];
            [eventTitle setBackgroundColor:[UIColor clearColor]];
            [self.contentView addSubview:eventTitle];
            
            height += 20;
        }
        else
        {
            UILabel *eventTitle = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, height, self.frame.size.width - leftPadding - 10, 20)];
            [eventTitle setTextAlignment:NSTextAlignmentLeft];
            [eventTitle setFont:[UIFont eventsCellTitle]];
            [eventTitle setText:@"Event Title Not Found"];
            [eventTitle setBackgroundColor:[UIColor clearColor]];
            [self.contentView addSubview:eventTitle];
            
            height += 20;
        }
        
        if(eventObject.eventDate != nil)
        {
            UILabel *eventDate = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, height, 140, 20)];
            [eventDate setFont:[UIFont eventsCellOther]];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"EEE MMM dd yyyy"];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
            NSString *formattedDate = [dateFormatter stringFromDate:eventObject.eventDate];
            [eventDate setText:formattedDate];
            [eventDate setTextColor:[UIColor eventDateColor]];
            [eventDate setBackgroundColor:[UIColor clearColor]];
            [self.contentView addSubview:eventDate];
            
            height += 20;
        }
        
        /*
        if(eventObject.city != nil)
        {
            UILabel *eventDate = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, height, 140, 20)];
            [eventDate setFont:[UIFont eventsCellOther]];
            [eventDate setText:eventObject.city];
            [eventDate setBackgroundColor:[UIColor clearColor]];
            [self.contentView addSubview:eventDate];
            
            height += 20;
        }
        */
        
        if(eventObject.genre != nil)
        {
            UILabel *eventDate = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, height, 140, 20)];
            [eventDate setFont:[UIFont eventsCellOther]];
            [eventDate setText:eventObject.genre];
            [eventDate setTextColor:[UIColor eventGenreColor]];
            [eventDate setBackgroundColor:[UIColor clearColor]];
            [self.contentView addSubview:eventDate];
            
            height += 20;
        }
        
        if(eventObject.location != nil)
        {
            UILabel *eventDate = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, height, 140, 20)];
            [eventDate setFont:[UIFont eventsCellOther]];
            [eventDate setText:eventObject.location];
            [eventDate setTextColor:[UIColor eventLocationColor]];
            [eventDate setBackgroundColor:[UIColor clearColor]];
            [self.contentView addSubview:eventDate];
            height += 20;
        }
        

        
        /*
        if(eventObject.details != nil)
        {
            CGSize size = [eventObject.details sizeWithFont:[UIFont eventsCellDescription] constrainedToSize:CGSizeMake(self.frame.size.width - leftPadding - 10, 100 - height - 5)];
            
            UILabel *eventDetails = nil;
            if(size.height < 100 - height - 5)
            {
                eventDetails = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, height, self.frame.size.width - leftPadding - 10, size.height)];
            }
            else
            {
                eventDetails = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, height, self.frame.size.width - leftPadding - 10, 100 - height - 5)];
            }
            
            [eventDetails setTextAlignment:NSTextAlignmentLeft];
            [eventDetails setFont:[UIFont eventsCellDescription]];
            [eventDetails setText:eventObject.details];
            [eventDetails setNumberOfLines:0];
            
            
            [eventDetails setBackgroundColor:[UIColor clearColor]];
            [self.contentView addSubview:eventDetails];
            
            height += 60;
        }    
         */
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
