//
//  LiveBulletView.h
//  BulletDemo
//
//  Created by 光 on 16/8/20.
//  Copyright © 2016年 光. All rights reserved.
//

#import <UIKit/UIKit.h>

/*--屏幕的宽高----*/
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight    [UIScreen mainScreen].bounds.size.height

typedef NS_ENUM(NSInteger, MoveStatus) {
    
    MoveStart,  // 开始进入屏幕
    MoveEnter,  // 完全进入屏幕
    MoveEnd     // 移出屏幕
};

@interface LiveBulletView : UIView
/**
 *  弹道标识
 */
@property (nonatomic, assign) int trajectory;
/**
 *  弹道移动状态回调
 */
@property (nonatomic, copy) void(^moveStatusBlock)(MoveStatus status);

/**
 *  初始化弹幕
 *
 *  @param comment 评论
 *
 */
- (instancetype)initWithComment:(NSString *)comment;

// 开始动画
- (void)startLiveBulletAnimation;

// 结束动画
- (void)stopLiveBulletAnimation;

@end
