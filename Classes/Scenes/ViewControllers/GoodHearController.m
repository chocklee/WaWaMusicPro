//
//  GoodHearController.m
//  WaWaMusicPro
//
//  Created by chock on 15/11/22.
//  Copyright © 2015年 chock. All rights reserved.
//

#import "GoodHearController.h"
#import "Colors.h"
#import "LoginController.h"
#import "YueRenModel.h"
#import "SDCycleScrollView.h"
#import "DataDownloadTool.h"
#import "URLs.h"
#import "GoodHearCell.h"
#import "MJRefresh.h"
#import "YueRenController.h"
#import "LieYueController.h"
#import "MusicModel.h"
#import "UserModel.h"
#import "YueRenDetailController.h"

@interface GoodHearController () <SDCycleScrollViewDelegate>

//cell的收缩展开
/*
////记录Cell的状态
//@property (nonatomic,assign) BOOL isOpen;
//
////记录选中的Cell的indexRow
//@property (nonatomic,assign) NSInteger selectedIndex;

//    //初始化selectedIndex
//    self.selectedIndex = -1;

//cell的点击事件
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    //取消选中
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.row == self.selectedIndex) {
//        self.isOpen = !self.isOpen;
//    } else {
//        self.isOpen = YES;
//    }
//    self.selectedIndex = indexPath.row;
//    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//}

//cell的高度设置
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == self.selectedIndex) {
//        if (self.isOpen) {
//            self.selectedIndex = indexPath.row;
//            return 530;
//        } else {
//            return 230;
//        }
//    } else {
//        return 230;
//    }
//}
*/

//存放好听页headerView内容的数组
@property (nonatomic,strong) NSMutableArray *goodHearHVArr;

//存放猎乐的数组
@property (nonatomic,strong) NSMutableArray *lieYueArr;

//刷新次数
@property (nonatomic,assign) NSInteger lieYueRefreshCount;

//音乐列表
@property (nonatomic,strong) NSMutableArray *musicArray;

//用户列表
@property (nonatomic,strong) NSMutableArray *userArray;

@end

@implementation GoodHearController

//懒加载
- (NSMutableArray *)goodHearHVArr {
    if (!_goodHearHVArr) {
        _goodHearHVArr = [NSMutableArray array];
    }
    return _goodHearHVArr;
}

- (NSMutableArray *)lieYueArr {
    if (!_lieYueArr) {
        _lieYueArr = [NSMutableArray array];
    }
    return _lieYueArr;
}

- (NSInteger)lieYueRefreshCount {
    if (!_lieYueRefreshCount) {
        _lieYueRefreshCount = 1;
    }
    return _lieYueRefreshCount;
}

- (NSMutableArray *)musicArray {
    if (!_musicArray) {
        _musicArray = [NSMutableArray array];
    }
    return _musicArray;
}

- (NSMutableArray *)userArray {
    if (!_userArray) {
        _userArray = [NSMutableArray array];
    }
    return _userArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    //设置title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    titleLabel.text = @"好听";
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

    //解决循环引用问题
    __weak UITableView *myTableView = self.tableView;
    
    //设置自动切换透明度(在导航栏下面自动隐藏)
    myTableView.mj_header.automaticallyChangeAlpha = YES;
    
    //下拉刷新
    [self pullRefresh:myTableView];
    
    //上拉加载
    [self pullLoad:myTableView];
    
    //加载headerView的内容
    [self getGoodHearHeader];
    
    //加载猎乐的内容
    [self getGoodHearLieYue];
}

//获得headerView的内容
//获得好听页headerView内容
- (void)getGoodHearHeader {
    [DataDownloadTool dataDowloadToolWithURL:kYRURL andMethod:@"GET" andBody:nil andBlock:^(NSData *data) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        for (NSDictionary *dic in arr) {
            YueRenModel *yueren = [[YueRenModel alloc] init];
            [yueren setValuesForKeysWithDictionary:dic];
            [yueren setValue:dic[@"id"] forKey:@"id"];
            [self.goodHearHVArr addObject:yueren];
        }
        [self.tableView reloadData];
    }];
    
}

//获得猎乐的内容
- (void)getGoodHearLieYue {
    NSString *urlStr = [NSString stringWithFormat:@"%@pageNo=%ld&pageSize=6&uid=(null)",kLYURL,self.lieYueRefreshCount++];
    [DataDownloadTool dataDowloadToolWithURL:urlStr andMethod:@"GET" andBody:nil andBlock:^(NSData *data) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray *musicData = [NSMutableArray array];
        NSMutableArray *userData = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
            LieYueModel *lieyue = [[LieYueModel alloc] init];
            [lieyue setValuesForKeysWithDictionary:dic];
            [self.lieYueArr addObject:lieyue];
            //音乐列表
            NSArray *listArr = dic[@"list"];
            [musicData addObject:listArr];
            //用户列表
            NSArray *listudArr = dic[@"listud"];
            [userData addObject:listudArr];
        }
        
        //解析音乐列表
        for (NSArray *musicArr in musicData) {
            NSMutableArray *mArr = [NSMutableArray array];
            for (NSDictionary *musicDic in musicArr) {
                MusicModel *music = [[MusicModel alloc] init];
                [music setValuesForKeysWithDictionary:musicDic];
                [mArr addObject:music];
            }
            [self.musicArray addObject:mArr];
        }
        //解析用户列表
        for (NSArray *userArr in userData) {
            NSMutableArray *uArr = [NSMutableArray array];
            for (NSDictionary *userDic in userArr) {
                UserModel *user = [[UserModel alloc] init];
                [user setValuesForKeysWithDictionary:userDic];
                [uArr addObject:user];
            }
            [self.userArray addObject:uArr];
        }
        
        [self.tableView reloadData];
    }];
}


//下拉刷新
- (void)pullRefresh:(UITableView *)tableView {
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //刷新headerView
        self.goodHearHVArr = nil;
        [self getGoodHearHeader];
        //刷新tableViewCell
        self.lieYueArr = nil;
        self.lieYueRefreshCount = 1;
        [self getGoodHearLieYue];
        //结束刷新
        [tableView.mj_header endRefreshing];
    }];
}

//上拉加载
- (void)pullLoad:(UITableView *)tableView {
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getGoodHearLieYue];
        //结束刷新
        [tableView.mj_footer endRefreshing];
    }];
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

#pragma mark - Table view data source
//设置section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//设置cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lieYueArr.count;
}

//设置cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodHearCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[GoodHearCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.lieYue = self.lieYueArr[indexPath.row];
    return cell;
}

//设置header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 230;
}

//获得轮播图的内容
- (NSDictionary *)getLunBoContent {
    //标题数组
    NSMutableArray *titleArr = [NSMutableArray array];
    //图片url数组
    NSMutableArray *urlArr = [NSMutableArray array];
    for (YueRenModel *yueren in self.goodHearHVArr) {
        [titleArr addObject:yueren.title];
        [urlArr addObject:yueren.image];
    }
    NSDictionary *dic = @{@"title":titleArr,@"image":urlArr};
    return dic;
}

//设置header视图的内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //初始化headerView
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 230)];
    headerView.backgroundColor = [UIColor whiteColor];
    //设置乐人的title
    UILabel *yuerenLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 50, 30)];
    yuerenLabel.text = @"乐人";
    yuerenLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:yuerenLabel];
    //设置往期按钮
    UIButton *yuerenButton = [UIButton buttonWithType:UIButtonTypeSystem];
    yuerenButton.frame = CGRectMake(self.view.frame.size.width - 50, 5, 40, 30);
    [yuerenButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [yuerenButton setTitle:@"往期" forState:UIControlStateNormal];
    //按钮的响应事件
    [yuerenButton addTarget:self action:@selector(didClickYRButton:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:yuerenButton];
    
    //获得实现轮播图的数据
    NSDictionary *dic = [self getLunBoContent];
    
    //轮播图设置
    SDCycleScrollView *cycleSV = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(5, 35, self.view.frame.size.width - 10, 190) imageURLStringsGroup:dic[@"image"]];
    //设置分页控件的位置
    cycleSV.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    //设置分页控件样式
    cycleSV.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    //设置title
    cycleSV.titlesGroup = dic[@"title"];
    //指定代理
    cycleSV.delegate = self;
    //设置滚动时间
    cycleSV.autoScrollTimeInterval = 3;
    [headerView addSubview:cycleSV];
    return headerView;
}

//cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LieYueController *lyVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"lieYue"];
    lyVC.lieYue = self.lieYueArr[indexPath.row];
    lyVC.musicArray = self.musicArray[indexPath.row];
    lyVC.userArray = self.userArray[indexPath.row];
    [self.navigationController pushViewController:lyVC animated:YES];
}

#pragma mark -- cell伸缩



//往期按钮点击事件
- (void)didClickYRButton:(UIButton *)sender {
    YueRenController *yrc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"yueRen"];
    [self.navigationController pushViewController:yrc animated:YES];
}


//获得轮播图的id
- (NSInteger)getLunBoID:(NSInteger)index {
    YueRenModel *yuren = self.goodHearHVArr[index];
    return [yuren.ID integerValue];
}

#pragma mark -- SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSInteger ID = [self getLunBoID:index];
    YueRenDetailController *yrDC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"yuerenDetail"];
    yrDC.ID = ID;
    NSLog(@"ID = %ld",yrDC.ID);
    [self.navigationController pushViewController:yrDC animated:YES];
}

//播放按钮响应事件
- (IBAction)didClickPlayBtnAction:(UIButton *)sender {
    NSLog(@"播放");
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
