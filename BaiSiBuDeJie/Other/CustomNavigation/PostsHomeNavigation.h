//
//  PostsHomeNavigation.h
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/22.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 帖子首页自定义NavigationView
 */
@interface PostsHomeNavigation : UIView

/**
 隐藏/显示导航栏
 @param velocity ScrollView拖拽速度
 */
- (void)scrollAnimationWithVelocity:(CGPoint)velocity;
@end
