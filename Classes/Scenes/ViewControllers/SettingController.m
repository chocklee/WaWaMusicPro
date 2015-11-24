//
//  SettingController.m
//  MyWaWa
//
//  Created by chock on 15/11/21.
//  Copyright © 2015年 chock. All rights reserved.
//

#import "SettingController.h"

@interface SettingController ()

//第一个section的数据
@property (nonatomic,strong) NSArray *firstArray;
//第二个section的数据
@property (nonatomic,strong) NSArray *secondArray;

@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //返回按钮
    UIBarButtonItem *returnBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return.png"] style:UIBarButtonItemStyleDone target:self action:@selector(didClickReturnBtn:)];
    returnBtnItem.tintColor = [UIColor lightGrayColor];
    //设置左侧按钮
    self.navigationItem.leftBarButtonItem = returnBtnItem;
    
    //设置title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    titleLabel.text = @"设置";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;

    //初始化数据
    self.firstArray = @[@"睡眠定时",@"清除缓存"];
    self.secondArray = @[@"给软件评分",@"反馈意见",@"关于挖哇",@"马上登录"];
}

//返回按钮点击事件
- (void)didClickReturnBtn:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
//设置section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

//设置cell的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else if (section == 1){
        return 3;
    } else {
        return 1;
    }
}

//设置cell的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (indexPath.section == 0) {
        cell.textLabel.text = self.firstArray[indexPath.row];
    } else if (indexPath.section == 1){
        cell.textLabel.text = self.secondArray[indexPath.row];
    } else {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = @"马上登录";
    }
    return cell;
}

//设置header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 20;
    }
    return 0;
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
