//
//  YueRenModel.m
//  WaWaMusicPro
//
//  Created by chock on 15/11/22.
//  Copyright © 2015年 chock. All rights reserved.
//

#import "YueRenModel.h"

@implementation YueRenModel

//重写dealloc方法,释放属性
- (void)dealloc
{
    self.ID = nil;
    self.title = nil;
    self.image = nil;
    self.songname = nil;
    self.bfnum = nil;
    self.hits = nil;
    self.articleUrl = nil;
    self.descriptions = nil;
    self.content = nil;
    self.songurl = nil;
    self.songphoto = nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    if ([key isEqualToString:@"description"]) {
        self.descriptions = value;
    }
}

@end
