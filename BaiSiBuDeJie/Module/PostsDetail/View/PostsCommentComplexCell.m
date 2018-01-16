//
//  PostsCommentComplexCell.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/15.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsCommentComplexCell.h"
#import "PostsCommentNormalCell.h"
#import <YYText/YYText.h>
#import "PostsDetailCommentModel.h"
#import "PostsCommentDetailComplexLayout.h"
#import "PostsCommentDetailNormalLayout.h"
#import "PostsModel.h"
#import "UIButton+Aliment.h"

@interface PostsCommentComplexCell()
<UITableViewDelegate,UITableViewDataSource,PostsCommentNormalCellDelegate>
@property (nonatomic,strong) UIImageView *avatar;
@property (nonatomic,strong) YYLabel *nickName;
@property (nonatomic,strong) UILabel *totalLikeLabel;
@property (nonatomic,strong) UIButton *upButton;
@property (nonatomic,strong) UIButton *downButton;
@property (nonatomic,strong) YYLabel *commentLabel;
@property (nonatomic,strong) UIImageView *commentImageView;
@property (nonatomic,strong) UIImageView *videoImageView;
@property (nonatomic,strong) UIImageView *startImageView;
@property (nonatomic,strong) UITableView *myTable;
@property (nonatomic,strong) PostsCommentDetailComplexLayout *layout;
@end

@implementation PostsCommentComplexCell
#pragma mark - Init Menthod
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)addSubViews{
    _avatar = [[UIImageView alloc]init];
    _avatar.size = CGSizeMake(30, 30);
    _avatar.origin = CGPointMake(kWBCellPaddingText, 8);
    _avatar.layer.cornerRadius = 30/2.0;
    _avatar.layer.masksToBounds = YES;
    [self.contentView addSubview:_avatar];
    
    _nickName = [YYLabel new];
    _nickName.userInteractionEnabled = YES;
    _nickName.left = _avatar.right + kWBCellPaddingText;
    _nickName.size = CGSizeMake(kScreenWidth - 30 - 2*kWBCellPaddingText - 120, 30);
    _nickName.centerY = _avatar.centerY;
    @weakify(self);
    [_nickName setHighlightTapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if ([weak_self.delegate respondsToSelector:@selector(didClickedComplexNickName:)]) {
            [weak_self.delegate didClickedComplexNickName:weak_self.layout.commentModel];
        }
    }];
    [self.contentView addSubview:_nickName];
    
    _totalLikeLabel = [UILabel new];
    _totalLikeLabel.textColor = [UIColor whiteColor];
    _totalLikeLabel.font = [UIFont systemFontOfSize:10];
    _totalLikeLabel.textAlignment = NSTextAlignmentCenter;
    _totalLikeLabel.size = CGSizeMake(30, 12);
    _totalLikeLabel.top = _avatar.bottom + 8;
    _totalLikeLabel.centerX = _avatar.centerX;
    _totalLikeLabel.layer.cornerRadius = 5;
    _totalLikeLabel.layer.masksToBounds = YES;
    [self.contentView addSubview:_totalLikeLabel];
    
    _downButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_downButton setImage:[UIImage imageNamed:@"mainCellCai_17x17_"] forState:UIControlStateNormal];
    [_downButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _downButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_downButton addTarget:self action:@selector(downButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_downButton];
    [_downButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-kWBCellPaddingText);
        make.centerY.equalTo(_avatar.mas_centerY);
    }];
    
    _upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_upButton setImage:[UIImage imageNamed:@"mainCellDing_17x17_"] forState:UIControlStateNormal];
    [_upButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _upButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_upButton addTarget:self action:@selector(upButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_upButton];
    [_upButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_downButton.mas_left).offset(-2.5*kWBCellPaddingText);
        make.centerY.equalTo(_avatar.mas_centerY);
    }];
    
    _commentLabel = [YYLabel new];
    _commentLabel.userInteractionEnabled = NO;
    _commentLabel.left = _nickName.left;
    _commentLabel.width = kScreenWidth - 30 - 3*kWBCellPaddingText;
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
    
    _myTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _myTable.separatorColor = RGBLINE;
    _myTable.backgroundColor = RGBColor(255, 242, 245, 1);
    [_myTable registerClass:[PostsCommentNormalCell class] forCellReuseIdentifier:@"PostsCommentNormalCell"];
    _myTable.left = _nickName.left;
    _myTable.width = kScreenWidth - 30 - 3*kWBCellPaddingText;
    _myTable.delegate = self;
    _myTable.dataSource = self;
    [self.contentView addSubview:_myTable];
}

#pragma mark - Event Response
- (void)downButtonClicked{
    if ([self.delegate respondsToSelector:@selector(didClickedComplexDownButton:)]) {
        [self.delegate didClickedComplexDownButton:_layout.commentModel];
    }
}

- (void)upButtonClicked{
    if ([self.delegate respondsToSelector:@selector(didClickedComplexUpButton:)]) {
        [self.delegate didClickedComplexUpButton:_layout.commentModel];
    }
}

#pragma mark - UITableView M
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _layout.commentModel.precmtsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostsDetailCommentModel *commentModel = _layout.commentModel.precmtsArray[indexPath.row];
    PostsCommentDetailNormalLayout *currentLayout = [[PostsCommentDetailNormalLayout alloc]initWithModel:commentModel];
    PostsCommentNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostsCommentNormalCell" forIndexPath:indexPath];
    cell.delegate = self;
    [cell setLayout:currentLayout index:indexPath.row + 1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostsDetailCommentModel *commentModel = _layout.commentModel.precmtsArray[indexPath.row];
    PostsCommentDetailNormalLayout *currentLayout = [[PostsCommentDetailNormalLayout alloc]initWithModel:commentModel];
    return currentLayout.totalHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - PostsCommentNormalCellDelegate
- (void)didClickedUpButton:(PostsDetailCommentModel *)model{
    SLog(@"顶(NormalCell)：%@",model.user.username);
}

- (void)didClickedDownButton:(PostsDetailCommentModel *)model{
     SLog(@"踩(NormalCell)：%@",model.user.username);
}

- (void)didClickedNickName:(PostsDetailCommentModel *)model{
    SLog(@"点击了昵称(NormalCell):%@",model.user.username);
}

#pragma mark - Setter && Getter
- (void)setComplexLayout:(PostsCommentDetailComplexLayout *)layout{
    if (!layout) {
        return;
    }
    _layout = layout;
    PostsDetailCommentModel *commentModel = layout.commentModel;
    
    /*进行布局*/
    CGFloat top = 0;
    top += layout.topMargin;
    top += layout.nickNameHeight;
    top += layout.nextCommentTopMargin;
    _myTable.top = top;
    _myTable.height = layout.allNextCommentHeight;
    _myTable.hidden = !layout.allNextCommentHeight;

    top += layout.allNextCommentHeight;
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
    [_avatar sd_setImageWithURL:[NSURL URLWithString:commentModel.user.profile_image]];
    _nickName.textLayout = layout.nickTextLayout;
    _commentLabel.textLayout = layout.textLayout;
    [_commentImageView sd_setImageWithURL:[NSURL URLWithString:commentModel.image.thumbnailArray[0]]];
    [_videoImageView sd_setImageWithURL:[NSURL URLWithString:commentModel.video.thumbnailArray[0]]];
    
    NSInteger likeNum = [commentModel.user.total_cmt_like_count integerValue];
    NSString *totalLikeNumber = nil;
    if (likeNum > 1000) {
        totalLikeNumber = [NSString stringWithFormat:@"%.1fk",likeNum/1000.0];
        _totalLikeLabel.backgroundColor = RGBColor(195, 182, 237, 1);
    }else{
        totalLikeNumber = [NSString stringWithFormat:@"%ld",likeNum];
        _totalLikeLabel.backgroundColor = RGBColor(166, 185, 210, 1);
    }
    _totalLikeLabel.text = totalLikeNumber;
    
    if (commentModel.like_count.integerValue > 0) {
        [_upButton setTitle:commentModel.like_count forState:UIControlStateNormal];
        [_upButton layoutImageTitleHorizontalOffSet:4];
    }
    if (commentModel.hate_count.integerValue > 0) {
        [_downButton setTitle:commentModel.hate_count forState:UIControlStateNormal];
        [_downButton layoutImageTitleHorizontalOffSet:4];
    }
    [self.myTable reloadData];
}

@end

