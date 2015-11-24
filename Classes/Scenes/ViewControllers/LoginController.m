//
//  LoginController.m
//  WaWaMusicPro
//
//  Created by chock on 15/11/21.
//  Copyright © 2015年 chock. All rights reserved.
//

#import "LoginController.h"
#import "SettingController.h"

@interface LoginController ()

@end

@implementation LoginController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //返回按钮
    UIBarButtonItem *returnBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return.png"] style:UIBarButtonItemStyleDone target:self action:@selector(didClickReturnBtn:)];
    returnBtnItem.tintColor = [UIColor lightGrayColor];
    //设置左侧按钮
    self.navigationItem.leftBarButtonItem = returnBtnItem;
    
    //设置按钮
    UIBarButtonItem *setBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting.png"] style:UIBarButtonItemStyleDone target:self action:@selector(didClickSetBtn:)];
    setBtnItem.tintColor = [UIColor lightGrayColor];
    //FM按钮
    UIBarButtonItem *fmBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"FM.png"] style:UIBarButtonItemStyleDone target:self action:@selector(didClickFMBtn:)];
    fmBtnItem.tintColor = [UIColor lightGrayColor];
    NSArray *items = @[setBtnItem,fmBtnItem];
    
    //设置右侧按钮
    self.navigationItem.rightBarButtonItems = items;
}

//返回按钮点击事件
- (void)didClickReturnBtn:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//设置按钮点击事件
- (void)didClickSetBtn:(UIBarButtonItem *)sender {
    SettingController *sc = [[SettingController alloc] init];
    [self.navigationController pushViewController:sc animated:YES];
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
