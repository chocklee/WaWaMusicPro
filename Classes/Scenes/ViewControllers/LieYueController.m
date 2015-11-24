//
//  LieYueController.m
//  WaWaMusicPro
//
//  Created by chock on 15/11/24.
//  Copyright © 2015年 chock. All rights reserved.
//

#import "LieYueController.h"
#import "LieYueModel.h"
#import "UIImageView+WebCache.h"
#import "MusicModel.h"
#import "LieYueMusicCell.h"
#import "UserModel.h"

@interface LieYueController () <UITableViewDataSource,UITableViewDelegate>

//contentSize的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightForContent;

//mname
@property (weak, nonatomic) IBOutlet UILabel *mnameLabel;

//mnum
@property (weak, nonatomic) IBOutlet UILabel *mnumLabel;

//听过
@property (weak, nonatomic) IBOutlet UILabel *histLabel;
//mphoto
@property (weak, nonatomic) IBOutlet UIImageView *mphotoView;

//mdesc
@property (weak, nonatomic) IBOutlet UILabel *mdescLabel;

//tableView
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//scrollView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation LieYueController

//重写updateViewConstraints设置heightForContent的大小
- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.heightForContent.constant = self.mnameLabel.frame.size.height + self.mnumLabel.frame.size.height + self.mphotoView.frame.size.height + self.mdescLabel.frame.size.height + self.tableView.frame.size.height + self.scrollView.frame.size.height + 50;
}

- (void)viewWillAppear:(BOOL)animated {
    //设置内容
    [self setUpView];
}

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
    
    [self.tableView reloadData];
}

//设置内容
- (void)setUpView {
    self.mnameLabel.text = self.lieYue.mname;
    self.mnumLabel.text = [NSString stringWithFormat:@"第%@期",self.lieYue.mnum];
    [self.mphotoView sd_setImageWithURL:[NSURL URLWithString:self.lieYue.mphoto]];
    self.histLabel.text = [NSString stringWithFormat:@"%@听过",self.lieYue.hist];
    self.mdescLabel.text = self.lieYue.mdesc;
    
    //设置scrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(40 * self.userArray.count + 20, self.scrollView.frame.size.height);
    for (int i = 0; i < self.userArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20 + i * 40, 0, 30, 30)];
        UserModel *user = self.userArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:user.pimg]];
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = 15;
        [self.scrollView addSubview:imageView];
    }
}

//返回按钮点击事件
- (void)didClickReturnBtn:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//FM按钮点击事件
- (void)didClickFMBtn:(UIBarButtonItem *)sender {
    NSLog(@"FM");
}


#pragma mark -- UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.musicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LieYueMusicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[LieYueMusicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.music = self.musicArray[indexPath.row];
    return cell;
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
