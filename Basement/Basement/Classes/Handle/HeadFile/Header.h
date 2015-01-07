//
//  Header.h
//  Basement
//
//  Created by Dylan on 15/1/3.
//  Copyright (c) 2015年 Dylan. All rights reserved.
//

#ifndef Basement_Header_h
#define Basement_Header_h

/*!
 *  @brief  Singeton
 */
#undef	X_SINGLETON_DEC
#define X_SINGLETON_DEC( __class ) \
+ (__class *)sharedInstance;

#undef	X_SINGLETON_DEF
#define X_SINGLETON_DEF( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}


/*!
 *  @brief  RGB Color
 */
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

/*!
 *  @brief  String
 */
#define NSStringFromBOOL(param) [NSString stringWithFormat:@"%d",param]
#define NSStringFromInt(param) [NSString stringWithFormat:@"%d",param]
#define NSStringFromLong(param) [NSString stringWithFormat:@"%ld",param]
#define NSStringFromLongLong(param) [NSString stringWithFormat:@"%lld",param]
#define NSStringFromDouble(param) [NSString stringWithFormat:@"%lf",param]
#define NSStringFromFloat(param) [NSString stringWithFormat:@"%f",param]

#import <objc/runtime.h>

#import "XBasic.h"

/*!
 *  @brief  Log
 */
#define _XLOG 1

#ifdef  _XLOG

#define	XLogOut(format,...);      NSLog(format, ##__VA_ARGS__);
#define XLogOutMethodFun          NSLog( @"[%@] %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd) );
#define XLogError(format,...);    NSLog(@"[error][%s][%d]" format,__func__,__LINE__,##__VA_ARGS__);
#define XLogWaring(format,...);   NSLog(@"[waring][%s][%d]" format,__func__,__LINE__,##__VA_ARGS__);
#define	XLogTeym(format,...);     {}

#else

#define XLogOut(format,...);      {}
#define XLogOutMethodFun          {}
#define XLogError(format,...);    {}
#define XLogWaring(format,...);   {}
#define	XLogTeym(format,...);     {}

#endif

/*!
 *  @brief  Vendors. Pod
 */
#import <INTULocationManager.h>
#import <MBProgressHUD.h>
#import <SVProgressHUD.h>
#import <UIDeviceUtil.h>
#import <Masonry.h>
#import <UIImageView+WebCache.h>

/*!
 *  @brief  AppDelegate
 */
#import "XAppDelegate.h"
#define XDelegate ((XAppDelegate *)[UIApplication sharedApplication].delegate)

#endif
