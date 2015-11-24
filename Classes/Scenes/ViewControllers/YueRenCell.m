//
//  YueRenCell.m
//  WaWaMusicPro
//
//  Created by chock on 15/11/23.
//  Copyright © 2015年 chock. All rights reserved.
//

#import "YueRenCell.h"
#import "UIImageView+WebCache.h"

@interface YueRenCell ()

//图片
@property (weak, nonatomic) IBOutlet UIImageView *imagePhoto;
//歌名
@property (weak, nonatomic) IBOutlet UILabel *songnameLael;
//点击量
@property (weak, nonatomic) IBOutlet UILabel *bfnumLabel;

@end

@implementation YueRenCell

//重写setYueRen
- (void)setYueRen:(YueRenModel *)yueRen {
    if (_yueRen != yueRen) {
        _yueRen = nil;
        _yueRen = yueRen;
        [self setYueRenCellContent];
    }
}

//设置Cell内容
- (void)setYueRenCellContent {
    [self.imagePhoto sd_setImageWithURL:[NSURL URLWithString:self.yueRen.image]];
    self.songnameLael.text = self.yueRen.songname;
    self.bfnumLabel.text = [NSString stringWithFormat:@"%@",self.yueRen.bfnum];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
