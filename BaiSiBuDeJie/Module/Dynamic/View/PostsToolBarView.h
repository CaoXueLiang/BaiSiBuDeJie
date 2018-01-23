//
//  PostsToolBarView.h
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/2.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PostsModel;
@protocol PostsToolBarViewDelegate <NSObject>
- (void)didClickedUpButton;
- (void)didClickedDownButton;
- (void)didClickedShareButton;
- (void)didClickedCommentButton;
@end

/**
 工具条View
 */
@interface PostsToolBarView : UIView
@property (nonatomic,weak) id<PostsToolBarViewDelegate> delegate;
@property (nonatomic,strong) PostsModel *model;
@end
