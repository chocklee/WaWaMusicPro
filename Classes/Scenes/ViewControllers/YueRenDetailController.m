//
//  YueRenDetailController.m
//  WaWaMusicPro
//
//  Created by chock on 15/11/24.
//  Copyright © 2015年 chock. All rights reserved.
//

#import "YueRenDetailController.h"
#import "URLs.h"
#import "YueRenModel.h"
#import "UIImageView+WebCache.h"

@interface YueRenDetailController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *descriptionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *songnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bfnumLabel;
@property (weak, nonatomic) IBOutlet UILabel *hitsLabel;

@property (nonatomic,strong) YueRenModel *yueren;

@end

@implementation YueRenDetailController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    titleLabel.text = @"猎乐";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    //返回按钮
    UIBarButtonItem *returnBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return.png"] style:UIBarButtonItemStyleDone target:self action:@selector(didClickReturnBtn:)];
    returnBtnItem.tintColor = [UIColor lightGrayColor];
    //设置左侧按钮
    self.navigationItem.leftBarButtonItem = returnBtnItem;
    //FM按钮
    UIBarButtonItem *fmBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"FM.png"] style:UIBarButtonItemStyleDone target:self action:@selector(didClickFMBtn:)];
    fmBtnItem.tintColor = [UIColor lightGrayColor];
    self.navigationItem.rightBarButtonItem = fmBtnItem;
    
    [self loadData];
    [self setUpView];
}

//加载数据
- (void)loadData {
    NSString *urlStr = [NSString stringWithFormat:@"%@ids=%ld&uid=0",kYRDEURL,self.ID];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *subStr = [str substringWithRange:NSMakeRange(6, str.length - 8)];
    NSData *subData = [subStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:subData options:NSJSONReadingAllowFragments error:nil];
    self.yueren = [[YueRenModel alloc] init];
    [self.yueren setValuesForKeysWithDictionary:dic];
    [self.yueren setValuesForKeysWithDictionary:dic[@"articleData"]];
    [self.yueren setValue:dic[@"description"] forKey:@"description"];
}

//设置页面
- (void)setUpView {
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.yueren.image]];
    self.descriptionsLabel.text = self.yueren.descriptions;
    self.songnameLabel.text = self.yueren.songname;
    self.bfnumLabel.text = [NSString stringWithFormat:@"%@人听过",self.yueren.bfnum];
    self.hitsLabel.text = [NSString stringWithFormat:@"%@人看过",self.yueren.hits];
}

//返回按钮点击事件
- (void)didClickReturnBtn:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
