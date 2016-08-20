//
//  LiveBulletView.m
//  BulletDemo
//
//  Created by 光 on 16/8/20.
//  Copyright © 2016年 光. All rights reserved.
//

#import "LiveBulletView.h"

#define kCommentFontSize    14  // 弹幕的字体大小
#define kPadding            10  // 弹幕子控件间隙
#define kBulletHeight       30  // 弹幕高度
#define kHeadImgViewHeight       30  // 头像高度

@interface LiveBulletView ()

@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UIImageView *headImgView;

@end

@implementation LiveBulletView

// 初始化弹幕
- (instancetype)initWithComment:(NSString *)comment
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        self.layer.cornerRadius = 8;
        
        // 计算弹幕长度
        CGFloat commentWidth = [self commentSize:comment];
        
        // 计算自身frame
        self.frame = CGRectMake(0, 0, commentWidth + 2*kPadding + kHeadImgViewHeight, kBulletHeight);
        
        // 赋值弹幕字符串
        self.commentLabel.text = comment;
        self.commentLabel.frame = CGRectMake(kPadding + kHeadImgViewHeight, 0, commentWidth, kBulletHeight);
        
        self.headImgView.frame = CGRectMake(-kPadding, -kPadding, kHeadImgViewHeight + kPadding, kHeadImgViewHeight + kPadding);
        
        self.headImgView.layer.cornerRadius = (kHeadImgViewHeight + kPadding) / 2;
        self.headImgView.layer.borderColor = [UIColor redColor].CGColor;
        self.headImgView.layer.borderWidth = 1;
        
        
    }
    return self;
}

// 开始动画
- (void)startLiveBulletAnimation
{
    /**
     *  1、根据弹幕长度执行动画效果
     *  2、根据 v = s / t ，
     *  当移动速度一致，此时 s 不同，所以 t 也不同，需要根据移动速度 设置 T的大小
     */
    
    
    // 运动轨迹总长
    CGFloat wholeWidth = kScreenWidth + CGRectGetWidth(self.bounds);
    
    // 运动时间
    CGFloat duration = [self computeDuration:wholeWidth];
    
    // 开始动画
    if (self.moveStatusBlock) {
        // 弹幕开始
        self.moveStatusBlock(MoveStart);
    }
    
    // t = s / v; s = 516 v = 130, 621-155,573-143,646-161,533-133
    // 进入屏幕的时间
    CGFloat speed = wholeWidth / duration;
    CGFloat enterDuration = CGRectGetWidth(self.bounds) / speed + 0.1;
    
    [self performSelector:@selector(enterScreen) withObject:nil afterDelay:enterDuration];
    
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
                         
                         // 状态回调，弹幕停止
                         if (self.moveStatusBlock) {
                             self.moveStatusBlock(MoveEnd);
                         }
                     }];
}

// 结束动画
- (void)stopLiveBulletAnimation
{
    // 取消执行延迟方法
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [self.layer removeAllAnimations];// uiview 的 animation就是layer上的动画
    
    [self removeFromSuperview];
}

- (void)enterScreen
{
    if (self.moveStatusBlock) {
        self.moveStatusBlock(MoveEnter);
    }
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

- (CGFloat)computeDuration:(CGFloat)wholeWidth
{
    // t = s / v; s = 516 v = 130,,,, 621-155,573-143,646-161,533-133
    CGFloat duration = wholeWidth / 130;
    
    return duration; //4;
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

- (UIImageView *)headImgView
{
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc] init];
        _headImgView.frame = CGRectZero;
        _headImgView.clipsToBounds = YES;
        
        [self addSubview:_headImgView];
    }
    return _headImgView;
}


@end
