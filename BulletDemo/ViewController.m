//
//  ViewController.m
//  BulletDemo
//
//  Created by 光 on 16/8/19.
//  Copyright © 2016年 光. All rights reserved.
//

#import "ViewController.h"
#import "BulletView.h"
#import "BulletManager.h"


@interface ViewController ()

@property (nonatomic, strong) BulletManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.manager = [[BulletManager alloc] init];
    
    // 拿到弹幕
    __weak __typeof(self) weakSelf = self;
    self.manager.generateViewBlock = ^(BulletView *view){
    
        [weakSelf addBulletView:view];
    };
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"start" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 70, 100, 40);
    [btn addTarget:self action:@selector(startBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)startBtnAction
{
    [self.manager startBullet];
    
}

- (void)addBulletView:(BulletView *)view
{
    // y 的 300 也可 宏定义出来
    view.frame = CGRectMake(kScreenWidth, 300 + view.trajectory*40, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    [self.view addSubview:view];
    
    [view startBulletAnimation];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
