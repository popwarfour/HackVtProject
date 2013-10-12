//
//  MapPinSelectorView.m
//  GoGreen
//
//  Created by Jordan Rouille on 9/5/13.
//  Copyright (c) 2013 Aidan Melen. All rights reserved.
//

#import "MapPinSelectorView.h"
#import <QuartzCore/QuartzCore.h>

#define MAX_ROTATION 3

@implementation MapPinSelectorView

- (id)initWithDuration:(float)spinDuration andFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.spinDuration = spinDuration;
        // Initialization code
        
        self.pinWheelBlue = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blueLeaf.png"]];
        [self.pinWheelBlue setFrame:CGRectMake(0, 0, 100, 100)];
        [self.pinWheelBlue setAlpha:1];
        [self addSubview:self.pinWheelBlue];
        
        self.pinWheelGreen = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"greenLeaf.png"]];
        [self.pinWheelGreen setFrame:CGRectMake(0, 0, 100, 100)];
        [self.pinWheelGreen setAlpha:1];
        [self addSubview:self.pinWheelGreen];
        
        self.pinWheelOrange = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"orangeLeaf.png"]];
        [self.pinWheelOrange setFrame:CGRectMake(0, 0, 100, 100)];
        [self.pinWheelOrange setAlpha:1];
        [self addSubview:self.pinWheelOrange];
        
        self.pinWheelRed = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redLeaf.png"]];
        [self.pinWheelRed setFrame:CGRectMake(0, 0, 100, 100)];
        [self.pinWheelRed setAlpha:1];
        [self addSubview:self.pinWheelRed];

        
        [self doOneForwardRotation];
    }
    return self;
}

-(void)doOneForwardRotation
{
    [self runSpinAnimationOnView:self.pinWheelBlue duration:self.spinDuration rotations:1 repeat:1];
    [self runSpinAnimationOnView:self.pinWheelGreen duration:self.spinDuration rotations:2 repeat:1];
    [self runSpinAnimationOnView:self.pinWheelOrange duration:self.spinDuration rotations:3 repeat:1];
    [self runSpinAnimationOnView:self.pinWheelRed duration:self.spinDuration rotations:4 repeat:1];
    
    VoidBlock animationBlock =
    ^{
        [self.pinWheelBlue setAlpha:1];
        [self.pinWheelGreen setAlpha:1];
        [self.pinWheelOrange setAlpha:1];
        [self.pinWheelRed setAlpha:1];
    };
    [UIView animateWithDuration:self.spinDuration / 10 animations: animationBlock];
    
    [self performSelector:@selector(setFinalPositionWithAllViews) withObject:nil afterDelay:self.spinDuration];
}

-(void)doOneBackwardsRotation
{
    [self runSpinAnimationOnView:self.pinWheelRed duration:self.spinDuration rotations:4 repeat:1];
    [self runSpinAnimationOnView:self.pinWheelOrange duration:self.spinDuration rotations:4 repeat:1];
    [self runSpinAnimationOnView:self.pinWheelGreen duration:self.spinDuration rotations:4 repeat:1];
    [self runSpinAnimationOnView:self.pinWheelBlue duration:self.spinDuration rotations:4 repeat:1];
    
    
    VoidBlock animationBlock =
    ^{
        [self.pinWheelBlue setAlpha:1];
        [self.pinWheelGreen setAlpha:1];
        [self.pinWheelOrange setAlpha:1];
        [self.pinWheelRed setAlpha:1];
    };
    [UIView animateWithDuration:self.spinDuration / 10 animations: animationBlock];
    
    [self performSelector:@selector(setFinalPositionWithAllViewsForFinish) withObject:nil afterDelay:self.spinDuration];
}

- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI / 2.0 /* full rotation*/ * rotations];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    rotationAnimation.removedOnCompletion = FALSE;
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

-(void)setFinalPositionWithAllViews
{
    VoidBlock animationBlock =
    ^{
        [self.pinWheelBlue setAlpha:0];
        [self.pinWheelGreen setAlpha:0];
        [self.pinWheelOrange setAlpha:0];
        [self.pinWheelRed setAlpha:0];
    };
    [UIView animateWithDuration:self.spinDuration / 10 animations: animationBlock];
    
    self.pinWheelBlue.transform = CGAffineTransformMakeRotation(M_PI / 2.0 * 1);
    self.pinWheelGreen.transform = CGAffineTransformMakeRotation(M_PI / 2.0 * 2);
    self.pinWheelOrange.transform = CGAffineTransformMakeRotation(M_PI / 2.0 * 3);
    self.pinWheelRed.transform = CGAffineTransformMakeRotation(M_PI / 2.0 * 4);
    
    [self performSelector:@selector(doOneBackwardsRotation) withObject:nil afterDelay:.5];
}

-(void)setFinalPositionWithAllViewsForFinish
{
    VoidBlock animationBlock =
    ^{
        [self.pinWheelBlue setAlpha:0];
        [self.pinWheelGreen setAlpha:0];
        [self.pinWheelOrange setAlpha:0];
        [self.pinWheelRed setAlpha:0];
    };
    [UIView animateWithDuration:self.spinDuration / 10 animations: animationBlock];
    
    self.pinWheelBlue.transform = CGAffineTransformMakeRotation(M_PI / 2.0 * 4);
    self.pinWheelGreen.transform = CGAffineTransformMakeRotation(M_PI / 2.0 * 4);
    self.pinWheelOrange.transform = CGAffineTransformMakeRotation(M_PI / 2.0 * 4);
    self.pinWheelRed.transform = CGAffineTransformMakeRotation(M_PI / 2.0 * 4);
    
    [self performSelector:@selector(doOneForwardRotation) withObject:nil afterDelay:.5];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
