//
//  LiveBulletManager.h
//  BulletDemo
//
//  Created by 光 on 16/8/20.
//  Copyright © 2016年 光. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LiveBulletView;

@interface LiveBulletManager : NSObject

// 弹幕的数据来源
@property (nonatomic, strong) NSMutableArray *dataSource;

// 回调到viewcontroller添加bulletview
@property (nonatomic, copy) void (^generateViewBlock)(LiveBulletView *view);

// 弹幕开始执行
- (void)startLiveBullet;

// 弹幕停止执行
- (void)stopLiveBullet;

@end
