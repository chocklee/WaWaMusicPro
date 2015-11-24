//
//  LieYueModel.m
//  WaWaMusicPro
//
//  Created by chock on 15/11/23.
//  Copyright © 2015年 chock. All rights reserved.
//

#import "LieYueModel.h"

@implementation LieYueModel

//重写dealloc,释放属性
- (void)dealloc {
    self.mname = nil;
    self.mnum = nil;
    self.mphoto = nil;
    self.hist = nil;
    self.mdesc = nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
