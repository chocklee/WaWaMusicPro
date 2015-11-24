//
//  LieYueController.h
//  WaWaMusicPro
//
//  Created by chock on 15/11/24.
//  Copyright © 2015年 chock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LieYueModel.h"

@interface LieYueController : UIViewController

//猎乐Model
@property (nonatomic,strong) LieYueModel *lieYue;

//音乐列表
@property (nonatomic,strong) NSMutableArray *musicArray;

//用户列表
@property (nonatomic,strong) NSMutableArray *userArray;

@end
