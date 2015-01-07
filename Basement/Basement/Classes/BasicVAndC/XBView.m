//
//  XBView.m
//  Basement
//
//  Created by Dylan on 15/1/2.
//  Copyright (c) 2015年 Dylan. All rights reserved.
//

#import "XBView.h"

@implementation XBView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        // 设置 width height = 设备当前屏幕尺寸
        self.width = [UIDeviceUtil width];
        self.height = [UIDeviceUtil height];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

@end
