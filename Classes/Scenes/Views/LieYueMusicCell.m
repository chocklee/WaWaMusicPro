//
//  LieYueMusicCell.m
//  WaWaMusicPro
//
//  Created by chock on 15/11/24.
//  Copyright © 2015年 chock. All rights reserved.
//

#import "LieYueMusicCell.h"
#import "UIImageView+WebCache.h"

@interface LieYueMusicCell ()

//song photo
@property (weak, nonatomic) IBOutlet UIImageView *songphotoView;

//song name
@property (weak, nonatomic) IBOutlet UILabel *songnameLabel;

//songer
@property (weak, nonatomic) IBOutlet UILabel *songerLabel;



@end

@implementation LieYueMusicCell

- (void)setMusic:(MusicModel *)music {
    if (_music != music) {
        _music = nil;
        _music = music;
        [self setMusicCellContent];
    }
}

//设置cell的内容
- (void)setMusicCellContent {
    [self.songphotoView sd_setImageWithURL:[NSURL URLWithString:self.music.songphoto]];
    self.songnameLabel.text = self.music.songname;
    self.songerLabel.text = self.music.songer;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
