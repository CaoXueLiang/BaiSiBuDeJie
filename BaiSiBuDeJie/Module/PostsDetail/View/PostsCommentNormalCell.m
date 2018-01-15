//
//  PostsCommentNormalCell.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/15.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsCommentNormalCell.h"
#import <YYText/YYText.h>
#import "PostsDetailCommentModel.h"
#import "PostsModel.h"
#import "PostsCommentDetailNormalLayout.h"

@interface PostsCommentNormalCell()
@property (nonatomic,strong) UILabel *rankLabel;
@property (nonatomic,strong) UILabel *nickName;
@property (nonatomic,strong) UIButton *upButton;
@property (nonatomic,strong) UIButton *downButton;
@property (nonatomic,strong) YYLabel *commentLabel;
@property (nonatomic,strong) UIImageView *commentImageView;
@property (nonatomic,strong) UIImageView *videoImageView;
@property (nonatomic,strong) UIImageView *startImageView;
@end

@implementation PostsCommentNormalCell
#pragma mark - Init Menthod
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)addSubViews{
    _rankLabel = [UILabel new];
    _rankLabel.textColor = [UIColor lightGrayColor];
    _rankLabel.font = [UIFont systemFontOfSize:12];
    _rankLabel.textAlignment = NSTextAlignmentCenter;
    _rankLabel.size = CGSizeMake(30, 30);
    _rankLabel.left = 0;
    _rankLabel.backgroundColor = RGBColor(242, 213, 220, 1);
    [self.contentView addSubview:_rankLabel];
    
    _downButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_downButton setImage:[UIImage imageNamed:@"mainCellCai_17x17_"] forState:UIControlStateNormal];
    [_downButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_downButton addTarget:self action:@selector(downButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _downButton.size = CGSizeMake(60, 30);
    _downButton.left = KWBCommentNormalWidth - 60;
    [self.contentView addSubview:_downButton];
    
    _upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_upButton setImage:[UIImage imageNamed:@"mainCellDing_17x17_"] forState:UIControlStateNormal];
    [_upButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_upButton addTarget:self action:@selector(downButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _upButton.size = CGSizeMake(60, 30);
    _upButton.left = KWBCommentNormalWidth - 120;
    [self.contentView addSubview:_upButton];
    
    _nickName = [UILabel new];
    _nickName.textColor = RGBColor(0, 59, 138, 1);
    _nickName.font = [UIFont systemFontOfSize:14];
    _nickName.left = _rankLabel.right + 8;
    _nickName.size = CGSizeMake(KWBCommentNormalWidth - 30 - 8 - 120, 30);
    [self.contentView addSubview:_nickName];
    
    _commentLabel = [YYLabel new];
    _commentLabel.userInteractionEnabled = NO;
    _commentLabel.left = _nickName.left;
    _commentLabel.width = KWBCommentNormalWidth - 30 - 2*kWBCellPaddingText;
    [self.contentView addSubview:_commentLabel];
    
    _commentImageView = [[UIImageView alloc]init];
    _commentImageView.contentMode = UIViewContentModeScaleAspectFill;
    _commentImageView.clipsToBounds = YES;
    _commentImageView.left = _nickName.left;
    _commentImageView.size = CGSizeMake(KWBDetailCommentImageHeight, KWBDetailCommentImageHeight);
    [self.contentView addSubview:_commentImageView];
    
    _videoImageView = [[UIImageView alloc]init];
    _videoImageView.contentMode = UIViewContentModeScaleAspectFill;
    _videoImageView.clipsToBounds = YES;
    _videoImageView.left = _nickName.left;
    _videoImageView.size = CGSizeMake(KWBDetailCommentVideoHeight, KWBDetailCommentVideoHeight);
    [self.contentView addSubview:_videoImageView];
    
    _startImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"capture_pre_play_normal_90x90_"]];
    _startImageView.size = CGSizeMake(40, 40);
    _startImageView.center = _videoImageView.center;
    [_videoImageView addSubview:_startImageView];
}

#pragma mark - Event Response
- (void)downButtonClicked{
    
}

- (void)upButtonClicked{
    
}

#pragma mark - Setter && Getter
- (void)setLayout:(PostsCommentDetailNormalLayout *)layout index:(NSInteger)index{
    if (!layout) {
        return;
    }
    PostsDetailCommentModel *commentModel = layout.commentModel;
    /*进行布局*/
    CGFloat top = 0;
    _rankLabel.top = layout.topMargin;
    _nickName.top = layout.topMargin;
    _upButton.top = layout.topMargin;
    _downButton.top = layout.topMargin;
    
    top += layout.topMargin + layout.nickNameHeight;
    top += layout.textTopMargin;
    _commentLabel.top = top;
    _commentLabel.height = layout.textHeight;
    _commentLabel.hidden = !layout.textHeight;
    
    top += layout.textHeight;
    top += layout.picTopMargin;
    _commentImageView.top = top;
    _commentImageView.hidden = !layout.picHeight;
    
    top += layout.picHeight;
    top += layout.videoTopMargin;
    _videoImageView.top = top;
    _videoImageView.hidden = !layout.videoHeight;
    
    
    /*进行赋值*/
    _rankLabel.text = [NSString stringWithFormat:@"%ld",index];
    _nickName.text = commentModel.user.username;
    _commentLabel.textLayout = layout.textLayout;
    [_commentImageView sd_setImageWithURL:[NSURL URLWithString:commentModel.image.thumbnailArray[0]]];
    [_videoImageView sd_setImageWithURL:[NSURL URLWithString:commentModel.video.thumbnailArray[0]]];
    if (commentModel.like_count.integerValue > 0) {
        [_upButton setTitle:commentModel.like_count forState:UIControlStateNormal];
    }
    if (commentModel.hate_count.integerValue > 0) {
        [_downButton setTitle:commentModel.hate_count forState:UIControlStateNormal];
    }
}

@end

