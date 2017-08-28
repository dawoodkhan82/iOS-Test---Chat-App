//
//  AnimationViewController.m
//  iOSTest
//
//  Created by App Partner on 12/13/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import "AnimationViewController.h"
#import "MenuViewController.h"
#import "iOSTest-Swift.h"

@interface AnimationViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@end

@implementation AnimationViewController

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make the UI look like it does in the mock-up.
 *
 * 2) Logo should spin when the user hits the spin button
 *
 * 3) User should be able to drag the logo around the screen with his/her fingers
 *
 * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation 
 *    section in Swift to show off your skills. Anything your heart desires!
 *
 **/

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Animation";
    Animations *animations = [[Animations alloc]init];
    //Background color loop function in Swift Animations file
    [animations backgroundColorLoop:self];
}

# pragma - Spin Action

- (IBAction)didPressSpinButton:(id)sender
{
    CABasicAnimation* rotateAction;
    rotateAction = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAction.toValue = [NSNumber numberWithFloat: M_PI * 2];
    rotateAction.duration = 1.0;
    rotateAction.repeatCount = 1;
    [self.logoImageView.layer addAnimation:rotateAction forKey:@"rotationAnimation"];
}

# pragma - Bounce Action

- (IBAction)didPressBounceButton:(id)sender {
    Animations *animations = [[Animations alloc]init];
    //Bounce function in Swift Animations file
    [animations bounce:_logoImageView];
}

# pragma - Fade Action

- (IBAction)didPressFadeButton:(id)sender
{
    Animations *animations = [[Animations alloc]init];
    //Fade function in Swift Animations file
    [animations fade:_logoImageView];
}


# pragma - TouchesMoved

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if ([touch view] == self.logoImageView)
    {
        CGPoint touchPosition = [touch locationInView:touch.window];
        CGRect oldFrame = self.logoImageView.frame;
        
        CGRect newFrame = CGRectMake(touchPosition.x - oldFrame.size.width/2, touchPosition.y -oldFrame.size.height/2, oldFrame.size.width, oldFrame.size.height);
        self.logoImageView.frame = newFrame;
    }
}


@end
