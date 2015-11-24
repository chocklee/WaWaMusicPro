//
//  MusicIndustryController.m
//  WaWaMusic
//
//  Created by chock on 15/11/21.
//  Copyright © 2015年 chock. All rights reserved.
//

#import "MusicIndustryController.h"
#import "LoginController.h"
#import "Colors.h"

@interface MusicIndustryController ()

@end

@implementation MusicIndustryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    titleLabel.text = @"音乐圈";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor colorWithRed:RED_COLOR green:GREEN_COLOR blue:BLUE_COLOR alpha:1];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    
    //登录按钮
    UIBarButtonItem *userBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"user.png"] style:UIBarButtonItemStyleDone target:self action:@selector(didClickLoginBtn:)];
    userBtnItem.tintColor = [UIColor lightGrayColor];
    //FM按钮
    UIBarButtonItem *fmBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"FM.png"] style:UIBarButtonItemStyleDone target:self action:@selector(didClickFMBtn:)];
    fmBtnItem.tintColor = [UIColor lightGrayColor];
    NSArray *items = @[userBtnItem,fmBtnItem];
    
    //设置右侧按钮
    self.navigationItem.rightBarButtonItems = items;
}

//登录按钮点击事件
- (void)didClickLoginBtn:(UIBarButtonItem *)sender {
    LoginController *loginVC = [[LoginController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

//FM按钮点击事件
- (void)didClickFMBtn:(UIBarButtonItem *)sender {
    NSLog(@"FM");
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
