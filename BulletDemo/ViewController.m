//
//  ViewController.m
//  BulletDemo
//
//  Created by 光 on 16/8/19.
//  Copyright © 2016年 光. All rights reserved.
//

#import "ViewController.h"
#import "BulletViewController.h"
#import "LiveViewController.h"

static NSString *cellId = @"CELL";

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tbView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"BulletView";
    } else {
        cell.textLabel.text = @"Live";
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        BulletViewController *bulletVC = [[BulletViewController alloc] init];
        [self.navigationController pushViewController:bulletVC animated:YES];
        
    } else if (indexPath.row == 1) {
       
        LiveViewController *liveVC = [[LiveViewController alloc] init];
        [self.navigationController pushViewController:liveVC animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
