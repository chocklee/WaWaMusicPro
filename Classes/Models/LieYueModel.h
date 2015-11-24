//
//  LieYueModel.h
//  WaWaMusicPro
//
//  Created by chock on 15/11/23.
//  Copyright © 2015年 chock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LieYueModel : NSObject

//mname
@property (nonatomic,copy) NSString *mname;

//mnum
@property (nonatomic,copy) NSString *mnum;

//mphoto
@property (nonatomic,copy) NSString *mphoto;

//hist 听过
@property (nonatomic,assign) NSNumber *hist;

//mdesc
@property (nonatomic,copy) NSString *mdesc;

@end
