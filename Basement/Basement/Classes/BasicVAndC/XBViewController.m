//
//  XBViewController.m
//  Basement
//
//  Created by Dylan on 15/1/2.
//  Copyright (c) 2015年 Dylan. All rights reserved.
//

#import "XBViewController.h"

@interface XBViewController ()

@end

@implementation XBViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.width = [UIDeviceUtil width];
        self.height = [UIDeviceUtil height];
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setStatusHidden: (BOOL)hidden {
    [[UIApplication sharedApplication] setStatusBarHidden:hidden withAnimation:UIStatusBarAnimationSlide];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)setTabHidden: (BOOL)hidden {
    
}

- (void)setNavigationAutoHidden: (BOOL)hidden {
    [self.navigationController setHidesBarsOnSwipe:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    //
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0) {
        //需要注意的是self.isViewLoaded是必不可少的，其他方式访问视图会导致它加载 ，在WWDC视频也忽视这一点。
        if (self.isViewLoaded && !self.view.window)
        {
            if ([XBasic ClassAttributes:self].count > 0) {
                [self setPropertiestoNil];
            }
            self.view = nil; // 目的是再次进入时能够重新加载调用viewDidLoad函数。
        }
    }
}

- (void)setPropertiestoNil {
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

@end
