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
#import "PostsCommentDetailNormalLayout.h"

@interface PostsCommentNormalCell()
@property (nonatomic,strong) UILabel *rankLabel;
@property (nonatomic,strong) UILabel *nickName;
@property (nonatomic,strong) UIButton *upButton;
@property (nonatomic,strong) UIButton *downButton;
@property (nonatomic,strong) UILabel *commentLabel;
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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = RGBColor(255, 242, 245, 1);
    }
    return self;
}

- (void)addSubViews{
    _rankLabel = [UILabel new];
    _rankLabel.textColor = [UIColor lightGrayColor];
    _rankLabel.font = [UIFont systemFontOfSize:12];
    _rankLabel.textAlignment = NSTextAlignmentCenter;
    _rankLabel.size = CGSizeMake(30, 30);
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
    
    _commentLabel = [UILabel new];
    _commentLabel.numberOfLines = 0;
    _commentLabel.left = _nickName.left;
    _commentLabel.width = KWBCommentNormalWidth - 30 - 2*kWBCellPaddingText;
    [self.contentView addSubview:_commentLabel];
    
    _commentImageView = [[UIImageView alloc]init];
    _commentImageView.contentMode = UIViewContentModeScaleAspectFill;
    _commentImageView.clipsToBounds = YES;
    _commentImageView.left = _nickName.left;
    [self.contentView addSubview:_commentImageView];
    
    _videoImageView = [[UIImageView alloc]init];
    _videoImageView.contentMode = UIViewContentModeScaleAspectFill;
    _videoImageView.clipsToBounds = YES;
    _videoImageView.left = _nickName.left;
    [self.contentView addSubview:_videoImageView];
    
    _startImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"capture_pre_play_normal_90x90_"]];
    _startImageView.size = CGSizeMake(40, 40);
    [_videoImageView addSubview:_startImageView];
}

#pragma mark - Event Response
- (void)downButtonClicked{
    
}

#pragma mark - Setter && Getter
- (void)setLayout:(PostsCommentDetailNormalLayout *)layout index:(NSInteger)index{
    if (!layout) {
        return;
    }
    PostsDetailCommentModel *commentModel = layout.commentModel;
    /*进行布局*/
    _rankLabel.text = [NSString stringWithFormat:@"%ld",index];
    _nickName.text = commentModel.user.username;
    [_upButton setTitle:@"" forState:UIControlStateNormal];
    
}

@end

