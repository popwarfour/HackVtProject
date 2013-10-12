//
//  MapPinSelectorView.h
//  GoGreen
//
//  Created by Jordan Rouille on 9/5/13.
//  Copyright (c) 2013 Aidan Melen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^VoidBlock)(void);

@interface MapPinSelectorView : UIView

@property int rotationCount;
@property float spinDuration;
@property (nonatomic, strong) UIImageView *pinWheelRed;
@property (nonatomic, strong) UIImageView *pinWheelBlue;
@property (nonatomic, strong) UIImageView *pinWheelGreen;
@property (nonatomic, strong) UIImageView *pinWheelOrange;


- (id)initWithDuration:(float)spinDuration andFrame:(CGRect)frame;

@end
