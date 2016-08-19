//
//  BulletManager.h
//  BulletDemo
//
//  Created by 光 on 16/8/19.
//  Copyright © 2016年 光. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BulletView;

@interface BulletManager : NSObject

// 回调到viewcontroller添加bulletview
@property (nonatomic, copy) void (^generateViewBlock)(BulletView *view);

// 弹幕开始执行
- (void)startBullet;

// 弹幕停止执行
- (void)stopBullet;

@end
