//
//  XAppDelegate.h
//  Basement
//
//  Created by Dylan on 14/12/30.
//  Copyright (c) 2014年 Dylan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class INTULocationManager;
@interface XAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/*!
 *  @brief  定位
 */
@property (strong, nonatomic) INTULocationManager * locMgr;

@end
