//
//  UserModel.h
//  WaWaMusicPro
//
//  Created by chock on 15/11/24.
//  Copyright © 2015年 chock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

//id
@property (nonatomic,copy) NSNumber *ID;

//username
@property (nonatomic,copy) NSString *username;

//头像
@property (nonatomic,copy) NSString *pimg;

//genter
@property (nonatomic,copy) NSString *genter;

//sign
@property (nonatomic,copy) NSString *sign;

@end
