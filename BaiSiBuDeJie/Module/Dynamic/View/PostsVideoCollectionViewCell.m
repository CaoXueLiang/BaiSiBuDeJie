//
//  PostsVideoCollectionViewCell.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/4.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsVideoCollectionViewCell.h"
#import "UIButton+Aliment.h"
#import "PostsModel.h"
#import <CHTCollectionViewWaterfallLayout/CHTCollectionViewWaterfallLayout.h>

@interface PostsVideoCollectionViewCell()
@property (nonatomic,strong) UIImageView *thumbnailImageView; //视频缩略图
@property (nonatomic,strong) UIButton *durationButton;        //时长
@property (nonatomic,strong) UIButton *commentButton;         //评论
@end

@implementation PostsVideoCollectionViewCell
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
        //self.contentView.backgroundColor = [UIColor clearColor];
        self.dk_backgroundColorPicker = DKColorPickerWithKey(CellBG);
    }
    return self;
}

- (void)addSubViews{
    _thumbnailImageView = [[UIImageView alloc]init];
    _thumbnailImageView.layer.cornerRadius = 5;
    _thumbnailImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_thumbnailImageView];
    [_thumbnailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    _durationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_durationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_durationButton setImage:[UIImage imageNamed:@"post_water_flow_comment_videoicon_11x13_"] forState:UIControlStateNormal];
    _durationButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _durationButton.userInteractionEnabled = NO;
    [self.contentView addSubview:_durationButton];
    [_durationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(8);
        make.bottom.equalTo(self.contentView).offset(-8);
    }];
    
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_commentButton setImage:[UIImage imageNamed:@"post_water_flow_comment_icon_15x15_"] forState:UIControlStateNormal];
    _commentButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _commentButton.userInteractionEnabled = NO;
    [self.contentView addSubview:_commentButton];
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-8);
        make.bottom.equalTo(self.contentView).offset(-8);
    }];
    
    [_durationButton layoutImageTitleHorizontalOffSet:7];
    [_commentButton layoutImageTitleHorizontalOffSet:7];
}

#pragma mark - Public Menthod
- (void)setModel:(PostsModel *)model{
    if (!model) {
        return;
    }
    _model = model;
    PostsVideoModel *videoModel = model.video;
    [_thumbnailImageView  sd_setImageWithURL:[NSURL URLWithString:videoModel.thumbnailArray[0]] placeholderImage:[UIImage imageNamed:@"post_placeholderImageN_145x30_"]];
    [_durationButton setTitle:[NSString stringWithFormat:@"%02zd:%02zd", videoModel.duration / 60, videoModel.duration % 60] forState:UIControlStateNormal];
    [_commentButton setTitle:model.comment forState:UIControlStateNormal];
    [_durationButton layoutImageTitleHorizontalOffSet:6];
    [_commentButton layoutImageTitleHorizontalOffSet:6];
}

+ (CGSize)cellSizeWithModel:(PostsModel *)model layout:(UICollectionViewLayout *)layout{
    CHTCollectionViewWaterfallLayout *currentLayout = (CHTCollectionViewWaterfallLayout *)layout;
    CGFloat cellWidth = (kScreenWidth - (currentLayout.columnCount - 1) *currentLayout.minimumColumnSpacing - currentLayout.sectionInset.left - currentLayout.sectionInset.right)/currentLayout.columnCount;
    CGFloat cellHeight = model.video.height * cellWidth / model.video.width;
    return CGSizeMake(cellWidth, cellHeight);
}

@end
