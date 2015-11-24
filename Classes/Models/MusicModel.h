//
//  MusicModel.h
//  WaWaMusicPro
//
//  Created by chock on 15/11/24.
//  Copyright © 2015年 chock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicModel : NSObject

//id
@property (nonatomic,copy) NSNumber *ID;

//songer
@property (nonatomic,copy) NSString *songer;

//songname
@property (nonatomic,copy) NSString *songname;

//songphoto
@property (nonatomic,copy) NSString *songphoto;

//time
@property (nonatomic,copy) NSNumber *time;

//mp3 Url
@property (nonatomic,copy) NSString *filename;

@end
