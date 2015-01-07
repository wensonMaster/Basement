//
//  XAppDelegate.m
//  Basement
//
//  Created by Dylan on 14/12/30.
//  Copyright (c) 2014年 Dylan. All rights reserved.
//

#import "XAppDelegate.h"
#import "XRootViewController.h"

@implementation XAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self getLocation];
    
    // set test root VC
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[XRootViewController new]];
    
    [self setAllStyle];
    
    return YES;
}

/*!
 *  @brief  Get Location / 精度 15m
 */
- (void)getLocation {
    
    self.locMgr = [INTULocationManager sharedInstance];
    
    [_locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyHouse timeout:15 delayUntilAuthorized:YES block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        
        if (status == INTULocationStatusSuccess) {
            
            XLogOut(@"------>获取位置成功<------")
        }
        else if (status == INTULocationStatusTimedOut) {
            
            XLogOut(@"------>获取位置失败<------")
        }
        else {
            
            XLogOut(@"------>位置内部错误<------")
        }
    }];
}

/*!
 *  @brief  All Style
 */
- (void)setAllStyle {
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.396 green:0.989 blue:0.765 alpha:1.000]];
}

@end
