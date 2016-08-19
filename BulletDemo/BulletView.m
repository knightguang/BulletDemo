//
//  BulletView.m
//  BulletDemo
//
//  Created by 光 on 16/8/19.
//  Copyright © 2016年 光. All rights reserved.
//

#import "BulletView.h"

#define kCommentFontSize    14  // 弹幕的字体大小
#define kPadding            10  // 弹幕子控件间隙
#define kBulletHeight       30  // 弹幕高度


@interface BulletView ()

@property (nonatomic, strong) UILabel *commentLabel;

@end

@implementation BulletView

// 初始化弹幕
- (instancetype)initWithComment:(NSString *)comment
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        
        // 计算弹幕长度
        CGFloat commentWidth = [self commentSize:comment];
        
        // 计算自身frame
        self.frame = CGRectMake(0, 0, commentWidth + 2*kPadding, kBulletHeight);
        
        // 赋值弹幕字符串
        self.commentLabel.text = comment;
        self.commentLabel.frame = CGRectMake(kPadding, 0, commentWidth, kBulletHeight);
        
    }
    return self;
}

// 开始动画
- (void)startBulletAnimation
{
    /**
     *  1、根据弹幕长度执行动画效果
     *  2、根据 v = s / t ，固定时间，距离越长，移动速度越快
     */
    
    
    // 固定时间
    CGFloat duration = 4.0f;
    
    // 运动轨迹总长
    CGFloat wholeWidth = kScreenWidth + CGRectGetWidth(self.bounds);
    
    // 开始动画
    /** 时间函数曲线相关
     *  UIViewAnimationOptionCurveEaseInOut     //时间曲线函数，由慢到快
     *  UIViewAnimationOptionCurveEaseIn        //时间曲线函数，由慢到特别快
     *  UIViewAnimationOptionCurveEaseOut       //时间曲线函数，由快到慢
     *  UIViewAnimationOptionCurveLinear        //时间曲线函数，匀速
     */
    
    // 改变frame值
    __block CGRect frame = self.frame;
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         // 弹幕滑动过程
                         frame.origin.x -= wholeWidth;
                         self.frame = frame;
        
                   } completion:^(BOOL finished) {
                       
                       // 弹幕移出屏幕
                       [self removeFromSuperview];
                       
                       // 状态回调
                       if (self.moveStatusBlock) {
                           self.moveStatusBlock();
                       }
    }];
    
}

// 结束动画
- (void)stopBulletAnimation
{
    [self.layer removeAllAnimations];// uiview 的 animation就是layer上的动画
    
    [self removeFromSuperview];
}

/**
 *  计算弹幕字符串长度
 */
- (CGFloat)commentSize:(NSString *)aComment
{
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:kCommentFontSize]
                                 };
    CGFloat width = [aComment sizeWithAttributes:attributes].width;
    return width;
}

#pragma mark - 懒加载
- (UILabel *)commentLabel
{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _commentLabel.font = [UIFont systemFontOfSize:kCommentFontSize];
        _commentLabel.textColor = [UIColor blueColor];
        _commentLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_commentLabel];
    }
    return _commentLabel;
}


@end
