//
//  BulletManager.m
//  BulletDemo
//
//  Created by 光 on 16/8/19.
//  Copyright © 2016年 光. All rights reserved.
//

#import "BulletManager.h"
#import "BulletView.h"

@interface BulletManager ()

// 弹幕的数据来源
@property (nonatomic, strong) NSMutableArray *dataSource;

// 弹幕使用过程中的数组变量
@property (nonatomic, strong) NSMutableArray *bulletComments;

// 存储弹幕view的数组
@property (nonatomic, strong) NSMutableArray *bulletViews;

@property (nonatomic, assign) BOOL isStopAnimation;


@end


@implementation BulletManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 刚开始弹幕是停止的
        self.isStopAnimation = YES;
    }
    return self;
}

- (void)startBullet
{
    if (!self.isStopAnimation) {
        return;
    }
    self.isStopAnimation = NO;
    
    // 移除之前的弹幕
    [self.bulletComments removeAllObjects];
    
    // 添加新的弹幕
    [self.bulletComments addObjectsFromArray:self.dataSource];
    
    [self initBulletComments];
}

- (void)stopBullet
{
    if (self.isStopAnimation) {
        return;
    }
    self.isStopAnimation = YES;
    
    // 快速遍历弹幕数组，停止弹幕动画以及延迟加载数据，并删除数据
    [self.bulletViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BulletView *view = obj;
        [view stopBulletAnimation];
        view = nil;
    }];
    [self.bulletViews removeAllObjects];
}

#pragma mark - 初始化弹幕，随机分配弹幕轨迹
- (void)initBulletComments
{
    NSMutableArray *trajectorys = [NSMutableArray arrayWithArray:@[@(0), @(1), @(2)]];
    
    int count = (int)trajectorys.count;
    
    for (int i = 0; i < count; i++) {
        
        if (self.bulletComments.count>0) {
            
            // 随机弹道
            NSInteger index = arc4random()%trajectorys.count;
            
            int trajectory = [trajectorys[index] intValue];
            
            [trajectorys removeObjectAtIndex:index];
            
            // 从弹幕数数组中取出第一个弹幕
            NSString *comment = [self.bulletComments firstObject];
            [self.bulletComments removeObjectAtIndex:0];
            
            // 创建一条弹幕view
            [self createBulletView:comment withTrajectory:trajectory];
        }
    }
}

- (void)createBulletView:(NSString *)aComment withTrajectory:(int)trajectory
{
    if (self.isStopAnimation) {
        return;
    }
    
    BulletView *view = [[BulletView alloc] initWithComment:aComment];
    view.trajectory = trajectory;
    
    [self.bulletViews addObject:view];
    
    __weak __typeof(view) weakView = view;
    __weak __typeof(self) weakSelf = self;
    view.moveStatusBlock = ^(MoveStatus status){
        
        if (weakSelf.isStopAnimation) {
            return;
        }
        
        switch (status) {
            case MoveStart:{
                // 弹幕开始进入屏幕，将view加入到bulletViews中管理
                [weakSelf.bulletViews addObject:weakView];
                break;
            }
            case MoveEnter:{
                // 弹幕完全进入到屏幕中，判断是否还有其他弹幕，如果有将在当前的弹道中创建一条弹幕
                NSString *comment = [weakSelf nextComment];
                
                if (comment) {
                    [weakSelf createBulletView:comment withTrajectory:trajectory];
                }
                break;
            }
            case MoveEnd:{
                // 弹幕完全飞出屏幕后销毁弹幕，并释放资源
                if ([weakSelf.bulletViews containsObject:weakView]) {
                    [weakView stopBulletAnimation];
                    [weakSelf.bulletViews removeObject:weakView];
                }
                
                // 实现循环（应实际需求，确定是否需要）
                if (weakSelf.bulletViews.count == 0) {
                    // 说明屏幕上没有弹幕了，开始循环滚动
                    weakSelf.isStopAnimation = YES;
                    [weakSelf startBullet];
                }
                break;
            }
            default:
                break;
        }  
    };
    
    // 如果viewcontroller调用了这个block，那么将view回调viewcontroller，进行下一步操作
    if (self.generateViewBlock) {
        self.generateViewBlock(view);
    }
}

- (NSString *)nextComment
{
    if (self.bulletComments.count == 0) {
        return nil;
    }
    NSString *aComment = [self.bulletComments firstObject];
    if (aComment) {
        [self.bulletComments removeObjectAtIndex:0];
    }
    return aComment;
}
#pragma mark - 懒加载
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] initWithArray:@[
                                                              @"弹幕1~~~~~~~~~",
                                                              @"弹幕2~~",
                                                              @"弹幕3~~~~~~~~~~~~~~~",
                                                              @"弹幕4~~~~~~~~~",
                                                              @"弹幕5~~~~~~~~~~~~~~~~~~",
                                                              @"弹幕6~~~~"
                                                              ]];
        
    }
    return _dataSource;
}

- (NSMutableArray *)bulletComments
{
    if (!_bulletComments) {
        _bulletComments = [[NSMutableArray alloc] init];
        
    }
    return _bulletComments;
}

- (NSMutableArray *)bulletViews
{
    if (!_bulletViews) {
        _bulletViews = [[NSMutableArray alloc] init];
        
    }
    return _bulletViews;
}

@end
