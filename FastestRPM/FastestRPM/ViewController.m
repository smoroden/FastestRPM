//
//  ViewController.m
//  FastestRPM
//
//  Created by Zach Smoroden on 2016-05-12.
//  Copyright © 2016 Zach Smoroden. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"

#define RADIANS(degrees) ((degrees * M_PI) / 180.0)
#define MAX_DEGREES      405
#define MIN_DEGREES      135.0
#define RANGE_DEGREES    (MAX_DEGREES - MIN_DEGREES)

#define LIMIT_VELOCITY           7500.0 // Points per second
#define LIMIT_VELOCITY_DELTA 10.0 // Points per second

#define RESET_DELAY      0.1 // Seconds
#define VELOCITY_DELAY   0.1 // Seconds


@interface ViewController ()

@property (nonatomic) CGFloat currVelocity;
@property (nonatomic) CGFloat maxVelocity;
@property (weak, nonatomic) IBOutlet UIImageView *needleView;
@property (nonatomic) CGAffineTransform minRotationTransform;


@property (nonatomic) double speed;
@property (nonatomic) double speedCoefficient;
@property (nonatomic) double angle;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.angle = (self.speedCoefficient * self.speed) + RADIANS(MIN_DEGREES);
    self.speedCoefficient = 0.002;
    
    // Do any additional setup after loading the view, typically from a nib.
    self.needleView.layer.anchorPoint = (CGPoint){0.5, 0.5};
    
    self.needleView.transform = CGAffineTransformMakeRotation(self.angle);
    
    //self.minRotationTransform = self.needleView.transform;
    
    //[self moveNeedleWithVelocity:0];
    
    
}
- (IBAction)detectPanVelocity:(UIPanGestureRecognizer *)sender {
    
    CGPoint componentVelocity = [sender velocityInView:self.view];
    
    self.speed = sqrt(pow(componentVelocity.x, 2) + pow(componentVelocity.y, 2));
    
    // Original method

//    if(sender.state == UIGestureRecognizerStateChanged) {
//        [self moveNeedleWithVelocity:self.speed];
//
//    }
    
    
    // Different method
    
    if (self.angle > RADIANS(MAX_DEGREES)) {
        self.angle = RADIANS(MAX_DEGREES);
    }
    if (self.angle < RADIANS(MIN_DEGREES)) {
        self.angle = RADIANS(MIN_DEGREES);
    }
    
    if (sender.state == UIGestureRecognizerStateChanged) {
        self.angle = (self.speedCoefficient * self.speed) + RADIANS(MIN_DEGREES);
        [UIView animateWithDuration:0.5 animations:^{
            [self.needleView setTransform:CGAffineTransformMakeRotation(self.angle)];
        }];
        
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        [UIView animateWithDuration:0.5 animations:^{
            if (self.angle > RADIANS((MAX_DEGREES + MIN_DEGREES) / 2 )) {
                [UIView animateWithDuration:0.10 animations:^{
                    [self.needleView setTransform:CGAffineTransformMakeRotation(RADIANS((MAX_DEGREES + MIN_DEGREES) / 2 ))];
                    
                }];
            }
            [self.needleView setTransform:CGAffineTransformMakeRotation(RADIANS(MIN_DEGREES))];
        }];
    }

}

-(void)differentMoveMethod {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)moveNeedleWithVelocity:(CGFloat)velocity {
//    self.currVelocity = velocity;
//    
//    // Calculate velocity of pan motion
//    self.maxVelocity = MAX(self.maxVelocity, velocity);
//    
//    // Calculate proportion of current velocity to velocity limit
//    CGFloat velocityProportion = velocity / LIMIT_VELOCITY;
//    
//    // Calculate proportion of RPM needle degree range
//  //  CGFloat degrees = MIN((RANGE_DEGREES * velocityProportion), RANGE_DEGREES);
//    
//    degrees -= 135;
//    
//    self.angle = degrees;
//    
//    // Move needle in degree range proportionate to velocity
//    self.needleView.transform = CGAffineTransformMakeRotation(RADIANS(degrees));
    }

@end
