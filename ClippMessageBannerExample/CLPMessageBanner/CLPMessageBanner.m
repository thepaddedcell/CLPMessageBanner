//
//  CLPMessageBanner.m
//  ClippMessageBannerExample
//
//  Created by Craig Stanford on 5/04/13.
//  Copyright (c) 2013 Craig Stanford. All rights reserved.
//

#import "CLPMessageBanner.h"

#define kCLPBannerErrorColour [UIColor colorWithRed:204.f/255.f green:0.f/255.f blue:0.f/255.f alpha:1.f]
#define kCLPBannerWarningColour [UIColor colorWithRed:250.f/255.f green:187.f/255.f blue:67.f/255.f alpha:1.f]
#define kCLPBannerInfoColour [UIColor colorWithRed:70.f/255.f green:199.f/255.f blue:234.f/255.f alpha:1.f]
#define kCLPBannerFont [UIFont systemFontOfSize:16.f]

@interface CLPMessageBanner ()

@property (nonatomic) CLPMessageBannerStyle style;
@property (nonatomic, strong) NSString* message;
@property (nonatomic, strong) CLPVoidBlock actionBlock;
@property (nonatomic, strong) UILabel* label;
@property (nonatomic) BOOL isOnScreen;


@end

@implementation CLPMessageBanner

- (id)initWithStyle:(CLPMessageBannerStyle)style message:(NSString *)message actionBlock:(CLPVoidBlock)actionBlock
{
    self = [super init];
    if (self) {
        self.style = style;
        self.message = message;
        self.actionBlock = actionBlock;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(resizeStatusBar:)
                                                     name:UIApplicationWillChangeStatusBarFrameNotification
                                                   object:nil];
    }
    return self;
}

- (void)loadView
{
    CGRect frame = [[[UIApplication sharedApplication] keyWindow] bounds];
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, -44, frame.size.width, 44)];
    
    switch (self.style) {
        case CLPMessageBannerStyleWarning:
            self.view.backgroundColor = kCLPBannerWarningColour;
            break;
        case CLPMessageBannerStyleError:
            self.view.backgroundColor = kCLPBannerErrorColour;
            break;
        case CLPMessageBannerStyleInfo:
        default:
            self.view.backgroundColor = kCLPBannerInfoColour;
            break;
    }
    
    self.label.text = self.message;
    [self.view addSubview:self.label];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.view.frame.size.width - 10, self.view.frame.size.height)];
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = kCLPBannerFont;
        _label.backgroundColor = self.view.backgroundColor;
    }
    return _label;
}

- (void)resizeStatusBar:(id)notification
{
    if (self.isOnScreen) {
        CGRect frame = self.view.frame;
        frame.origin.y = [[UIApplication sharedApplication] statusBarFrame].size.height;
        [UIView animateWithDuration:0.3f animations:^{
            self.view.frame = frame;
        }];
    }
}

- (void)viewTapped:(id)sender
{
    if(self.actionBlock) {
        self.actionBlock();
    }
    
    [self hide];
}

- (void)hide
{
    CGRect frame = self.view.frame;
    frame.origin.y = -frame.size.height;
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame = frame;
    } completion:^(BOOL finished) {
        self.isOnScreen = NO;
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

- (void)show
{
    [self showForDuration:2.f];
}

- (void)showForDuration:(NSTimeInterval)duration
{
    self.isOnScreen = YES;
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.view];
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] addChildViewController:self];
    
    CGRect frame = self.view.frame;
    frame.origin.y = [[UIApplication sharedApplication] statusBarFrame].size.height;
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame = frame;
    } completion:^(BOOL finished) {
        double delayInSeconds = duration;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self hide];
        });
    }];
}

@end
