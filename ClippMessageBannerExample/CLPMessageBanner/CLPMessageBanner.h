//
//  CLPMessageBanner.h
//  ClippMessageBannerExample
//
//  Created by Craig Stanford on 5/04/13.
//  Copyright (c) 2013 Craig Stanford. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CLPVoidBlock)();

typedef enum {
    CLPMessageBannerStyleError,
    CLPMessageBannerStyleWarning,
    CLPMessageBannerStyleInfo,
    CLPMessageBannerStyleDefault = CLPMessageBannerStyleInfo
} CLPMessageBannerStyle;

@interface CLPMessageBanner : UIViewController

- (id)initWithStyle:(CLPMessageBannerStyle)style message:(NSString*)message actionBlock:(CLPVoidBlock)actionBlock;
- (void)show;
- (void)showForDuration:(NSTimeInterval)duration;

@end
