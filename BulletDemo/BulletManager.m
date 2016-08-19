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

@end


@implementation BulletManager

- (void)startBullet
{
    // 移除之前的弹幕
    [self.bulletComments removeAllObjects];
    
    // 添加新的弹幕
    [self.bulletComments addObjectsFromArray:self.dataSource];
    
    [self initBulletComments];
}

- (void)stopBullet
{

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
    BulletView *view = [[BulletView alloc] initWithComment:aComment];
    view.trajectory = trajectory;
    
    [self.bulletViews addObject:view];
    
    __weak __typeof(view) weakView = view;
    __weak __typeof(self) weakSelf = self;
    view.moveStatusBlock = ^{
        
        // 移出屏幕后销毁弹幕，并释放资源
        [weakView stopBulletAnimation];
        [weakSelf.bulletViews removeObject:weakView];
    };
    
    // 如果viewcontroller调用了这个block，那么将view回调viewcontroller，进行下一步操作
    if (self.generateViewBlock) {
        self.generateViewBlock(view);
    }
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
