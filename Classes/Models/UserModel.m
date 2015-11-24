//
//  UserModel.m
//  WaWaMusicPro
//
//  Created by chock on 15/11/24.
//  Copyright © 2015年 chock. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (void)dealloc {
    self.ID = nil;
    self.username = nil;
    self.pimg = nil;
    self.genter = nil;
    self.sign = nil;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
