//
//  PostsMemberCenterNavigation.h
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/26.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PostsMemberCenterNavigationDelegate <NSObject>
- (void)didClickBackButton;
- (void)didClickMoreButton;
@end

/**
 个人中心自定义NavigationView
 */
@class PostsModel;
@interface PostsMemberCenterNavigation : UIView
@property (nonatomic,weak) id<PostsMemberCenterNavigationDelegate> delegate;
@property (nonatomic,strong) PostsModel *model;
- (void)scrollWithOffSetY:(CGFloat)offSetY;
@end

