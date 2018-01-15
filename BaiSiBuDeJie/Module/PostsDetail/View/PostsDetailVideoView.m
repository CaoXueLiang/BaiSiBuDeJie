//
//  PostsDetailVideoView.m
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/14.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsDetailVideoView.h"

@implementation PostsDetailVideoView
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
    
}

@end
