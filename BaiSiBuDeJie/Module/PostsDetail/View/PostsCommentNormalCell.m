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
#import "UIButton+Aliment.h"

@interface PostsCommentNormalCell()
@property (nonatomic,strong) UILabel *rankLabel;
@property (nonatomic,strong) YYLabel *nickName;
@property (nonatomic,strong) UIButton *upButton;
@property (nonatomic,strong) UIButton *downButton;
@property (nonatomic,strong) YYLabel *commentLabel;
@property (nonatomic,strong) UIImageView *commentImageView;
@property (nonatomic,strong) UIImageView *videoImageView;
@property (nonatomic,strong) UIImageView *startImageView;
@property (nonatomic,strong) PostsDetailCommentModel *commentModel;
@end

@implementation PostsCommentNormalCell
#pragma mark - Init Menthod
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)addSubViews{
    _rankLabel = [UILabel new];
    _rankLabel.textColor = [UIColor lightGrayColor];
    _rankLabel.font = [UIFont systemFontOfSize:11];
    _rankLabel.textAlignment = NSTextAlignmentCenter;
    _rankLabel.size = CGSizeMake(20, 15);
    _rankLabel.left = 0;
    _rankLabel.top = 10;
    _rankLabel.backgroundColor = RGBColor(242, 213, 220, 1);
    [self.contentView addSubview:_rankLabel];
    
    _downButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_downButton setImage:[UIImage imageNamed:@"mainCellCai_17x17_"] forState:UIControlStateNormal];
    [_downButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _downButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_downButton addTarget:self action:@selector(downButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_downButton];
    [_downButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-kWBCellPaddingText);
        make.centerY.equalTo(_rankLabel.mas_centerY);
    }];
    
    _upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_upButton setImage:[UIImage imageNamed:@"mainCellDing_17x17_"] forState:UIControlStateNormal];
    [_upButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _upButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_upButton addTarget:self action:@selector(upButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_upButton];
    [_upButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_downButton.mas_left).offset(-2.5*kWBCellPaddingText);
        make.centerY.equalTo(_rankLabel.mas_centerY);
    }];
    
    _nickName = [YYLabel new];
    _nickName.left = _rankLabel.right + 8;
    _nickName.size = CGSizeMake(KWBCommentNormalWidth - 30 - 8 - 100, 30);
    _nickName.centerY = _rankLabel.centerY;
    [self.contentView addSubview:_nickName];
    @weakify(self);
    [_nickName setHighlightTapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if ([weak_self.delegate respondsToSelector:@selector(didClickedNickName:)]) {
            [weak_self.delegate didClickedNickName:weak_self.commentModel];
        }
    }];
    
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
    [_videoImageView addSubview:_startImageView];
    [_startImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.center.equalTo(_videoImageView);
    }];
}

#pragma mark - Event Response
- (void)downButtonClicked{
    if ([self.delegate respondsToSelector:@selector(didClickedDownButton:)]) {
        [self.delegate didClickedDownButton:_commentModel];
    }
}

- (void)upButtonClicked{
    if ([self.delegate respondsToSelector:@selector(didClickedUpButton:)]) {
        [self.delegate didClickedUpButton:_commentModel];
    }
}

#pragma mark - Setter && Getter
- (void)setLayout:(PostsCommentDetailNormalLayout *)layout index:(NSInteger)index{
    if (!layout) {
        return;
    }
    PostsDetailCommentModel *commentModel = layout.commentModel;
    _commentModel = commentModel;
    
    /*进行布局*/
    CGFloat top = 0;
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
    _nickName.textLayout = layout.nickNameTextLayout;
    _commentLabel.textLayout = layout.textLayout;
    [_commentImageView sd_setImageWithURL:[NSURL URLWithString:commentModel.image.thumbnailArray[0]]];
    [_videoImageView sd_setImageWithURL:[NSURL URLWithString:commentModel.video.thumbnailArray[0]]];
    if (commentModel.like_count.integerValue > 0) {
        [_upButton setTitle:commentModel.like_count forState:UIControlStateNormal];
        [_upButton layoutImageTitleHorizontalOffSet:4];
    }
    if (commentModel.hate_count.integerValue > 0) {
        [_downButton setTitle:commentModel.hate_count forState:UIControlStateNormal];
        [_downButton layoutImageTitleHorizontalOffSet:4];
    }
}

@end

