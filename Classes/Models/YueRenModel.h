//
//  YueRenModel.h
//  WaWaMusicPro
//
//  Created by chock on 15/11/22.
//  Copyright © 2015年 chock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YueRenModel : NSObject

//id
@property (nonatomic,copy) NSString *ID;
//标题
@property (nonatomic,copy) NSString *title;
//图片
@property (nonatomic,copy) NSString *image;
//听过
@property (nonatomic,copy) NSNumber *bfnum;


//看过
@property (nonatomic,copy) NSNumber *hits;
//articleUrl
@property (nonatomic,copy) NSString *articleUrl;
//description
@property (nonatomic,copy) NSString *descriptions;

//articleData
//content
@property (nonatomic,copy) NSString *content;

//songurl
@property (nonatomic,copy) NSString *songurl;

//songname
@property (nonatomic,copy) NSString *songname;

//songphoto
@property (nonatomic,copy) NSString *songphoto;

@end
