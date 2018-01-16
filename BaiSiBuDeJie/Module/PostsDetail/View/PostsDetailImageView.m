//
//  PostsDetailImageView.m
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/14.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsDetailImageView.h"
#import "PostsModel.h"

@interface PostsDetailImageView()
@property (nonatomic,strong) YYAnimatedImageView *thumbnailView;  //图片大图
@property (nonatomic,strong) UIImageView *typeGifView;            //Gif图标
@end

@implementation PostsDetailImageView
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size.width = kScreenWidth;
    }
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    _thumbnailView = [YYAnimatedImageView new];
    _thumbnailView.contentMode = UIViewContentModeScaleAspectFill;
    _thumbnailView.clipsToBounds = YES;
    [self addSubview:_thumbnailView];
    [_thumbnailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    _typeGifView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common-gif"]];
    [self addSubview:_typeGifView];
    [_typeGifView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(31, 31));
        make.left.equalTo(_thumbnailView.mas_left);
        make.top.equalTo(self);
    }];
}

#pragma mark - Setter Menthod
- (void)setPostsModel:(PostsModel *)postsModel{
    if (!postsModel) {
        return;
    }
    _postsModel = postsModel;
    PostsImageModel *imageModel = postsModel.image;
    
    /*加载图片*/
    [_thumbnailView yy_setImageWithURL:[NSURL URLWithString:imageModel.bigArray[0]] placeholder:nil];
    
    /*判断是否是Gif图片*/
    NSString *imageURL = imageModel.bigArray[0];
    if ([imageURL.pathExtension.lowercaseString isEqualToString:@"gif"]) {
        _typeGifView.hidden = NO;
    }else{
        _typeGifView.hidden = YES;
    }
}

@end
