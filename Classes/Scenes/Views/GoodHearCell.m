//
//  GoodHearCell.m
//  WaWaMusicPro
//
//  Created by chock on 15/11/22.
//  Copyright © 2015年 chock. All rights reserved.
//

#import "GoodHearCell.h"
#import "UIImageView+WebCache.h"

@interface GoodHearCell ()

//mname
@property (weak, nonatomic) IBOutlet UILabel *mnameLabel;
//mnum
@property (weak, nonatomic) IBOutlet UILabel *mnumLabel;
//听过
@property (weak, nonatomic) IBOutlet UILabel *histLabel;
//图片
@property (weak, nonatomic) IBOutlet UIImageView *mphoto;




@end

@implementation GoodHearCell

//重写setLieYue
- (void)setLieYue:(LieYueModel *)lieYue {
    if (_lieYue != lieYue) {
        _lieYue = nil;
        _lieYue = lieYue;
        [self setLieYueCellContent];
    }
}

//设置cell的内容
- (void)setLieYueCellContent {
    self.mnameLabel.text = self.lieYue.mname;
    self.mnumLabel.text = [NSString stringWithFormat:@"第%@期",self.lieYue.mnum];
    [self.mphoto sd_setImageWithURL:[NSURL URLWithString:self.lieYue.mphoto]];
    self.histLabel.text = [NSString stringWithFormat:@"%@听过",self.lieYue.hist];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
