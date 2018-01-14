//
//  PostsDetailHeaderView.m
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/14.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsDetailHeaderView.h"
#import "PostsDetailHeaderLayout.h"
#import "PostsProfileView.h"
#import "PostsToolBarView.h"
#import <YYText/YYText.h>

@interface PostsDetailHeaderView()
@property (nonatomic,strong) PostsProfileView *profileView;
@property (nonatomic,strong) PostsToolBarView *toolBarView;
@property (nonatomic,strong) YYLabel *contentLabel;
@property (nonatomic,strong) UILabel *publishLabel;
@property 
@end

@implementation PostsDetailHeaderView
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)addSubViews{
    
}

#pragma mark - Public Menthod
- (void)setLayout:(PostsDetailHeaderLayout *)layout{
    
}

@end
