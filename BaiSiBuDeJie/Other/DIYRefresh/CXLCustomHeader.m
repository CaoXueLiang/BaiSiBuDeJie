//
//  CXLCustomHeader.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2017/12/29.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "CXLCustomHeader.h"

@implementation CXLCustomHeader
#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare{
    [super prepare];
    
    // 设置普通状态的动画图片
    [self setImages:@[[UIImage imageNamed:@"bdj_mj_refresh_1"]] forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"bdj_mj_refresh_%zd", i]];
        [refreshingImages addObject:image];
    }
    //[self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    //设置文本颜色
    self.lastUpdatedTimeLabel.textColor = RGBColor(129, 129, 129, 1);
    self.stateLabel.textColor = RGBColor(129, 129, 129, 1);   
}

@end
