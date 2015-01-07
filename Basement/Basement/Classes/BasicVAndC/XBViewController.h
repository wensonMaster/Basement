//
//  XBViewController.h
//  Basement
//
//  Created by Dylan on 15/1/2.
//  Copyright (c) 2015年 Dylan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XBViewController : UIViewController

/*!
 *  @brief  子类需要重载 . 释放属性
 */
- (void)setPropertiestoNil;

/*!
 *  @brief  隐藏
 *
 *  @param hidden 需要的话 子类进行调用或重载
 */
- (void)setStatusHidden: (BOOL)hidden;
- (void)setTabHidden: (BOOL)hidden;
- (void)setNavigationAutoHidden: (BOOL)hidden;

@property (nonatomic, strong) NSString * pageName;

@property (nonatomic) int width;
@property (nonatomic) int height;

@end
