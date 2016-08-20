//
//  BulletViewController.m
//  BulletDemo
//
//  Created by 光 on 16/8/20.
//  Copyright © 2016年 光. All rights reserved.
//

#import "BulletViewController.h"
#import "BulletView.h"
#import "BulletManager.h"

@interface BulletViewController ()

@property (nonatomic, strong) BulletManager *manager;

@end

@implementation BulletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
    UIButton *btnStop = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnStop setTitle:@"stop" forState:UIControlStateNormal];
    [btnStop setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    btnStop.frame = CGRectMake(300, 70, 100, 40);
    [btnStop addTarget:self action:@selector(stopAnimatiom) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnStop];
}

- (void)startBtnAction
{
    [self.manager startBullet];
    
}
- (void)stopAnimatiom
{
    [self.manager stopBullet];
    
}

- (void)addBulletView:(BulletView *)view
{
    // y 的 300,40, 也可 宏定义出来
    view.frame = CGRectMake(kScreenWidth, 200 + view.trajectory*40, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    [self.view addSubview:view];
    
    [view startBulletAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
