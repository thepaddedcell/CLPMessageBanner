//
//  CLPViewController.m
//  ClippMessageBannerExample
//
//  Created by Craig Stanford on 5/04/13.
//  Copyright (c) 2013 Craig Stanford. All rights reserved.
//

#import "CLPViewController.h"
#import "CLPMessageBanner.h"

@interface CLPViewController ()

- (IBAction)showBannerPressed:(id)sender;
- (IBAction)showWarningPressed:(id)sender;
- (IBAction)showInfoPressed:(id)sender;

@end

@implementation CLPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showBannerPressed:(id)sender
{
    [[[CLPMessageBanner alloc] initWithStyle:CLPMessageBannerStyleError
                                     message:@"This is an error"
                                 actionBlock:^{
                                     NSLog(@"Error Tapped");
                                 }] show];
}

- (void)showWarningPressed:(id)sender
{
    [[[CLPMessageBanner alloc] initWithStyle:CLPMessageBannerStyleWarning
                                     message:@"This is a warning"
                                 actionBlock:^{
                                     NSLog(@"Warning Tapped");
                                 }] show];
}

- (void)showInfoPressed:(id)sender
{
    [[[CLPMessageBanner alloc] initWithStyle:CLPMessageBannerStyleInfo
                                     message:@"This is information"
                                 actionBlock:^{
                                     NSLog(@"Info Tapped");
                                 }] show];
}

@end
