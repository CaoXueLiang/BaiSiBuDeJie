//
//  PostsImageView.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/2.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsImageView.h"
#import "DALabeledCircularProgressView.h"
#import "PostsModel.h"
#import "UIButton+Aliment.h"

@interface PostsImageView()
@property (nonatomic,strong) YYAnimatedImageView *thumbnailView;  //图片缩略图
@property (nonatomic,strong) UIImageView *typeGifView;            //Gif图标
@property (nonatomic,strong) UIImageView *placeHolderView;        //占位图
@property (nonatomic,strong) UIButton *checkBigButton;            //查看大图按钮
@property (nonatomic,strong) DALabeledCircularProgressView *progressView; //进度条
@end

@implementation PostsImageView
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
    }
    self = [super initWithFrame:frame];
    if (self) {
        [self addsubViews];
    }
    return self;
}

- (void)addsubViews{
    _thumbnailView = [YYAnimatedImageView new];
    _thumbnailView.contentMode = UIViewContentModeScaleAspectFill;
    _thumbnailView.clipsToBounds = YES;
    [self addSubview:_thumbnailView];
    [_thumbnailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self).offset(kWBCellPadding);
        make.right.equalTo(self).offset(-kWBCellPadding);
    }];
    
    _typeGifView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common-gif"]];
    [self addSubview:_typeGifView];
    [_typeGifView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(31, 31));
        make.left.equalTo(_thumbnailView.mas_left);
        make.top.equalTo(self);
    }];
    
    _placeHolderView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"imageBackground_75x15_"]];
    [self addSubview:_placeHolderView];
    [_placeHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 30));
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(10);
    }];
    
    _progressView = [[DALabeledCircularProgressView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    _progressView.roundedCorners = YES;
    _progressView.progressLabel.textColor = [UIColor lightGrayColor];
    _progressView.progressLabel.font = [UIFont systemFontOfSize:20];
    _progressView.progressTintColor = [UIColor lightGrayColor];
    _progressView.trackTintColor = kWBCellHighlightColor;
    [self addSubview:_progressView];
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(120, 120));
        make.centerY.equalTo(self).offset(10);
    }];
    
    
    _checkBigButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_checkBigButton setBackgroundImage:[UIImage imageNamed:@"see-big-picture-background_285x43_"] forState:UIControlStateNormal];
    [_checkBigButton setImage:[UIImage imageNamed:@"see-big-picture_19x19_"] forState:UIControlStateNormal];
    [_checkBigButton setTitle:@"点击查看大图" forState:UIControlStateNormal];
    [_checkBigButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _checkBigButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_checkBigButton];
    [_checkBigButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.mas_equalTo(45);
        make.left.equalTo(self).offset(kWBCellPadding);
        make.right.equalTo(self).offset(-kWBCellPadding);
    }];
    [_checkBigButton layoutImageTitleHorizontalOffSet:10];
}

#pragma mark - Setter && Getter
- (void)setModel:(PostsModel *)model{
    if (!model) {
        return;
    }
    _model = model;
    PostsImageModel *imageModel = model.image;
    
    /*加载图片，并且显示进度条*/
    [_thumbnailView yy_cancelCurrentImageRequest];
    [_thumbnailView yy_setImageWithURL:[NSURL URLWithString:imageModel.bigArray[0]] placeholder:nil options:kNilOptions progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        /*显示加载进度*/
        CGFloat progress = receivedSize / (float)expectedSize;
        _progressView.hidden = NO;
        _placeHolderView.hidden = NO;
        [_progressView setProgress:progress animated:YES];
        [_progressView.progressLabel setText:[NSString stringWithFormat:@"%.0f"@"%@",progress *100,@"%"]];
        
    } transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        _progressView.hidden = YES;
        _placeHolderView.hidden = YES;
    }];
    
    /*判断是大图还是小图，当高度超过屏幕高度时，就认为是大图*/
    if (imageModel.height >= kScreenWidth) {
        _thumbnailView.contentMode = UIViewContentModeTop;
        _checkBigButton.hidden = NO;
    }else{
        _thumbnailView.contentMode = UIViewContentModeScaleAspectFill;
        _checkBigButton.hidden = YES;
    }
    
    /*判断是否是Gif图片*/
    NSString *imageURL = imageModel.bigArray[0];
    if ([imageURL.pathExtension.lowercaseString isEqualToString:@"gif"]) {
        _typeGifView.hidden = NO;
    }else{
        _typeGifView.hidden = YES;
    }
}

@end

