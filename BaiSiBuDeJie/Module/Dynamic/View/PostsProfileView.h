//
//  PostsProfileView.h
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/2.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PostsProfileViewDelegate <NSObject>
- (void)didClickUser;
@end

/**
 个人信息View
 */
@class PostsModel;
@interface PostsProfileView : UIView
@property (nonatomic,weak) id<PostsProfileViewDelegate> delegate;
@property (nonatomic,strong) PostsModel *model;
/**感谢点赞动画*/
- (void)thanksAnimation;
@end
