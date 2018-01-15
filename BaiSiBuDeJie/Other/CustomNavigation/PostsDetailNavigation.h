//
//  PostsDetailNavigation.h
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/5.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PostsDetailNavigationDelegate <NSObject>
- (void)didClickedButton:(NSInteger)index;
@end

/**
 帖子详情自定义NavigationView
 */
@class PostsModel;
@interface PostsDetailNavigation : UIView
@property (nonatomic,weak) id<PostsDetailNavigationDelegate> delegate;
@property (nonatomic,strong) PostsModel *model;
@end
