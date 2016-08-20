//
//  LiveViewController.m
//  BulletDemo
//
//  Created by 光 on 16/8/20.
//  Copyright © 2016年 光. All rights reserved.
//

#import "LiveViewController.h"
#import "LiveBulletView.h"
#import "LiveBulletManager.h"


@interface LiveViewController ()

@property (nonatomic, strong) LiveBulletManager *manager;

@end

@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.manager = [[LiveBulletManager alloc] init];
    
    // 拿到弹幕
    __weak __typeof(self) weakSelf = self;
    self.manager.generateViewBlock = ^(LiveBulletView *view){
        
        [weakSelf addBulletView:view];
    };
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"start" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 70, 100, 40);
    [btn addTarget:self action:@selector(startBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btnStop = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnStop setTitle:@"stop" forState:UIControlStateNormal];
    [btnStop setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnStop.frame = CGRectMake(270, 70, 100, 40);
    [btnStop addTarget:self action:@selector(stopAnimatiom) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnStop];
    
    NSMutableArray *dataArr = [NSMutableArray arrayWithArray:@[
                         @"按时到家啊",
                         @"驱蚊器去",@"而且我答复是",
                         @"去hiU币vuriuv",@"图挥洒拿到",@"666666",
                         @"777777777777777",@"666",@"辣鸡",@"菜狗子",
                         @"房间12313123123",@"房间12313131有激情",@"撒丢hi爱护肤八部语无",@"撒U盾hiuadiuninx",
                         @"99999999",@"111111",@"1",@"111111111",@"111",
                         @"11",@"222",@"333",@"13123123123",@"我熬我奇偶擦UI纯牛奶",
                         @"弹幕来啦",@"飞起来",@"安大安师大",@"星球称霸啊",@"真菜",
                         @"澡堂开业啦~",@"69号技师来一下",@"前排瓜子花生矿泉水",@"屌的不行",@"高大哥",
                         @"方舟啊",@"屁股先锋",@"求BGM",@"BGM：打死不看做上角",@"爱的供养",
                         @"爱的供养现场版",@"666",@"顿肚子",@"睡个",@"爱UI会阿牛给你个",
                         @"牛董666",@"毒瘤牛！",@"毒牛子",@"8991873891",@"12321",
                         @"123",@"hi花哦啊哦覅",@"功夫不好不要大力",@"怼啊",@"不要怂",
                         @"就是干",@"则尼玛累啊",@"nsmutablearray",@"hello world"
                         ]];
    [self.manager setDataSource:dataArr];
}

- (void)startBtnAction
{
    [self.manager startLiveBullet];
    
}
- (void)stopAnimatiom
{
    [self.manager stopLiveBullet];
    
}

- (void)addBulletView:(LiveBulletView *)view
{
    // y 的 300,40, 也可 宏定义出来
    view.frame = CGRectMake(kScreenWidth, 200 + view.trajectory*40, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    [self.view addSubview:view];
    
    [view startLiveBulletAnimation];
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
