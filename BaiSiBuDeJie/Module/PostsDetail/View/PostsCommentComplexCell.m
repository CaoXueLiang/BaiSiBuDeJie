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

@interface PostsCommentComplexCell()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIImageView *avatar;
@property (nonatomic,strong) YYLabel *nickName;
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
    _nickName.userInteractionEnabled = NO;
    _nickName.left = _avatar.right + kWBCellPaddingText;
    _nickName.size = CGSizeMake(kScreenWidth - 30 - 2*kWBCellPaddingText - 120, 30);
    _nickName.centerY = _avatar.centerY;
    [self.contentView addSubview:_nickName];
    
    _downButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_downButton setImage:[UIImage imageNamed:@"mainCellCai_17x17_"] forState:UIControlStateNormal];
    [_downButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_downButton addTarget:self action:@selector(downButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _downButton.size = CGSizeMake(60, 30);
    _downButton.left = kScreenWidth - 60;
    _downButton.centerY = _avatar.centerY;
    [self.contentView addSubview:_downButton];
    
    _upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_upButton setImage:[UIImage imageNamed:@"mainCellDing_17x17_"] forState:UIControlStateNormal];
    [_upButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_upButton addTarget:self action:@selector(upButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _upButton.size = CGSizeMake(60, 30);
    _upButton.left = kScreenWidth - 120;
    _upButton.centerY = _avatar.centerY;
    [self.contentView addSubview:_upButton];
    
    _commentLabel = [YYLabel new];
    _commentLabel.userInteractionEnabled = NO;
    _commentLabel.left = _nickName.left;
    _commentLabel.width = kScreenWidth - 40 - 2*kWBCellPaddingText;
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
    
    _myTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _myTable.separatorColor = RGBLINE;
    _myTable.backgroundColor = [UIColor orangeColor];
    [_myTable registerClass:[PostsCommentNormalCell class] forCellReuseIdentifier:@"PostsCommentNormalCell"];
    _myTable.left = _nickName.left;
    _myTable.width = kScreenWidth - 40 - 3*kWBCellPaddingText;
    _myTable.delegate = self;
    _myTable.dataSource = self;
    [self.contentView addSubview:_myTable];
}

#pragma mark - Event Response
- (void)downButtonClicked{
    
}

- (void)upButtonClicked{
    
}

#pragma mark - UITableView M
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _layout.commentModel.precmtsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostsDetailCommentModel *commentModel = _layout.commentModel.precmtsArray[indexPath.row];
    PostsCommentDetailNormalLayout *currentLayout = [[PostsCommentDetailNormalLayout alloc]initWithModel:commentModel];
    PostsCommentNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostsCommentNormalCell" forIndexPath:indexPath];
    [cell setLayout:currentLayout index:indexPath.row];
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
    NSMutableAttributedString *userString = [[NSMutableAttributedString alloc]initWithString:commentModel.user.username];
    userString.yy_color = RGBColor(0, 59, 138, 1);
    userString.yy_font = [UIFont systemFontOfSize:14];
    _nickName.attributedText = userString;
    _commentLabel.textLayout = layout.textLayout;
    [_commentImageView sd_setImageWithURL:[NSURL URLWithString:commentModel.image.thumbnailArray[0]]];
    [_videoImageView sd_setImageWithURL:[NSURL URLWithString:commentModel.video.thumbnailArray[0]]];
    if (commentModel.like_count.integerValue > 0) {
        [_upButton setTitle:commentModel.like_count forState:UIControlStateNormal];
    }
    if (commentModel.hate_count.integerValue > 0) {
        [_downButton setTitle:commentModel.hate_count forState:UIControlStateNormal];
    }
    [self.myTable reloadData];
}

@end

