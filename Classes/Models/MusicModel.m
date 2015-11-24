//
//  MusicModel.m
//  WaWaMusicPro
//
//  Created by chock on 15/11/24.
//  Copyright © 2015年 chock. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel

- (void)dealloc {
    self.ID = nil;
    self.songer = nil;
    self.songname = nil;
    self.songphoto = nil;
    self.time = nil;
    self.filename = nil;
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
