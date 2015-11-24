//
//  YueRenController.m
//  WaWaMusicPro
//
//  Created by chock on 15/11/23.
//  Copyright © 2015年 chock. All rights reserved.
//

#import "YueRenController.h"
#import "YueRenCell.h"
#import "MJRefresh.h"
#import "URLs.h"
#import "YueRenDetailController.h"

@interface YueRenController ()

//存放乐人的数组
@property (nonatomic,strong) NSMutableArray *yueRenArr;

//乐人刷新次数
@property (nonatomic,assign) NSInteger yueRenRefreshCount;

@end

@implementation YueRenController

//懒加载
- (NSMutableArray *)yueRenArr {
    if (!_yueRenArr) {
        _yueRenArr = [NSMutableArray array];
    }
    return _yueRenArr;
}

- (NSInteger)yueRenRefreshCount {
    if (!_yueRenRefreshCount) {
        _yueRenRefreshCount = 1;
    }
    return _yueRenRefreshCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    titleLabel.text = @"乐人";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor grayColor];
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
    //添加右侧按钮
    self.navigationItem.rightBarButtonItem = fmBtnItem;
    
    
    __weak UITableView *myTableView = self.tableView;
    //设置自动切换透明度(在导航栏下面自动隐藏)
    myTableView.mj_header.automaticallyChangeAlpha = YES;
    
    //下拉刷新
    [self pullRefresh:myTableView];
    
    //上拉加载
    [self pullLoad:myTableView];
    
    //加载数据
    [self loadData];
}

- (void)loadData {
    NSString *urlStr = [NSString stringWithFormat:@"%@pageNo=%ld&pageSize=10&uid=0&callback=data",kYRAllURL,self.yueRenRefreshCount++];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *subStr = [str substringWithRange:NSMakeRange(5, str.length - 6)];
    NSData *subData = [subStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:subData options:NSJSONReadingAllowFragments error:nil];
    for (NSDictionary *dic in arr) {
        YueRenModel *yueren = [[YueRenModel alloc] init];
        [yueren setValuesForKeysWithDictionary:dic];
        NSDictionary *subDic = dic[@"articleData"];
        [yueren setValuesForKeysWithDictionary:subDic];
        [self.yueRenArr addObject:yueren];
    }
    [self.tableView reloadData];
}


//下拉刷新
- (void)pullRefresh:(UITableView *)tableView {
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.yueRenArr = nil;
        self.yueRenRefreshCount = 1;
        [self loadData];
        //结束刷新
        [tableView.mj_header endRefreshing];
    }];
}

//上拉加载
- (void)pullLoad:(UITableView *)tableView {
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadData];
        //结束刷新
        [tableView.mj_footer endRefreshing];
    }];
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

#pragma mark - Table view data source
//设置section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.yueRenArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YueRenCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yueRenCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[YueRenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"yueRenCell"];
    }
    cell.yueRen = self.yueRenArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YueRenDetailController *yrDC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"yuerenDetail"];
    YueRenModel *yueRen = self.yueRenArr[indexPath.row];
    yrDC.ID = [yueRen.ID integerValue];
    NSLog(@"ID = %ld",yrDC.ID);
    [self.navigationController pushViewController:yrDC animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
